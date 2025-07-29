<?php
// run_updates.php - The update orchestrator script

echo "========================================\n";
echo "==      DATABASE UPDATE SCRIPT      ==\n";
echo "========================================\n\n";

// Step 1: Include the environment setup
// This will provide the $dbo object and helper functions.
// Use @ to suppress "headers already sent" warnings if any script outputs text.
@include_once __DIR__.'/core.php';

// Check if the core include was successful and $dbo is available.
if (!isset($dbo) || !$dbo instanceof DboWrapper) {
    die("FATAL ERROR: core.php could not be loaded or did not initialize the \$dbo object correctly.\n");
}

// Get the raw PDO object for transaction control
$pdo = $dbo->getPdo();

// Step 2: Ensure the 'updates' table exists
try {
    // This query will fail if the table doesn't exist.
    // We check for its existence before trying to read from it.
    $pdo->query("SELECT 1 FROM `updates` LIMIT 1");
} catch (Exception $e) {
    echo "NOTICE: The `updates` table does not seem to exist.\n";
    echo "This is expected on a fresh installation.\n";
    echo "Attempting to create it from 'update/create_updates.sql'...\n";
    
    $creation_script_path = __DIR__.'/update/create_updates.sql';
    if (!file_exists($creation_script_path)) {
        die("FATAL ERROR: Could not find '{$creation_script_path}'. Cannot proceed.\n");
    }
    
    try {
        $sql = file_get_contents($creation_script_path);
        $pdo->exec($sql);
        echo "SUCCESS: `updates` table created successfully.\n\n";
    } catch (Exception $ex) {
        die("FATAL ERROR: Failed to create the `updates` table: " . $ex->getMessage() . "\n");
    }
}


// Step 3: Get the list of already executed updates
$executed_updates = [];
$results = $dbo->fetchArray("SELECT `version` FROM `updates`");
foreach ($results as $row) {
    $executed_updates[] = $row['version'];
}
echo "Found " . count($executed_updates) . " previously executed updates.\n\n";


// Step 4: Scan the 'update' directory for available update files
$update_dir = __DIR__ . '/update';
$all_files = scandir($update_dir);

$available_updates = [];
foreach ($all_files as $file) {
    // Match files like '2_1.php', '2_4_15.sql'
    if (preg_match('/^([\d_]+)\.(php|sql)$/', $file, $matches)) {
        $version = $matches[1];
        $type = $matches[2];
        $available_updates[$version][$type] = $file;
    }
}

// Step 5: Sort the updates by version number
// ksort sorts by key (the version string), which works correctly for this naming scheme.
ksort($available_updates);

echo "Found " . count($available_updates) . " available update versions.\n";
echo "----------------------------------------\n";

// Step 6: Process each available update
$updates_to_run = 0;
foreach ($available_updates as $version => $files) {
    
    // Check if this version has already been executed
    if (in_array($version, $executed_updates)) {
        continue; // Skip to the next version
    }

    $updates_to_run++;
    echo "\nProcessing update version: {$version}\n";
    
    $sql_file = $files['sql'] ?? null;
    $php_script = $files['php'] ?? null;

    try {
        // Start a transaction
        $pdo->beginTransaction();
        
        // --- Execute SQL file if it exists ---
        if ($sql_file) {
            echo "-> Executing SQL script: {$sql_file}...\n";
            $sql_content = file_get_contents($update_dir . '/' . $sql_file);
            if (trim($sql_content) !== '') {
                $pdo->exec($sql_content);
                echo "   ...SQL script executed successfully.\n";
            } else {
                echo "   ...SQL script is empty, skipping execution.\n";
            }
        }
        
        // --- Execute PHP script if it exists ---
        if ($php_script) {
            echo "-> Executing PHP script: {$php_script}...\n";
            // The included script will have access to $dbo and helper functions
            include $update_dir . '/' . $php_script;
            echo "   ...PHP script executed successfully.\n";
        }

        // --- Record the update in the database ---
        $stmt = $pdo->prepare(
            "INSERT INTO `updates` (`version`, `sql`, `script`, `done`) VALUES (:version, :sql, :script, :done)"
        );
        $stmt->execute([
            ':version' => $version,
            ':sql'     => $sql_file ? 1 : 0,
            ':script'  => $php_script ? 1 : 0,
            ':done'    => time() // Use timestamp for 'done'
        ]);

        // If everything was successful, commit the transaction
        $pdo->commit();
        echo "-> SUCCESS: Version {$version} has been applied and recorded.\n";

    } catch (Exception $e) {
        // An error occurred, rollback the transaction
        $pdo->rollBack();
        
        echo "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
        echo "!!  ERROR during update {$version}!\n";
        echo "!!  All changes for this version have been rolled back.\n";
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
        echo "Error message: " . $e->getMessage() . "\n";
        echo "File: " . $e->getFile() . " on line " . $e->getLine() . "\n";
        
        // Stop the entire update process
        die("\nUpdate process aborted due to a critical error.\n");
    }
}

if ($updates_to_run === 0) {
    echo "\nYour database is already up to date. No new updates to apply.\n";
} else {
    echo "\n----------------------------------------\n";
    echo "All new updates have been applied successfully!\n";
}

echo "========================================\n"; 