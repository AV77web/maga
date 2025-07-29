<?php
// core.php

// --- 1. Database Configuration ---
$dbHost = 'localhost';
$dbName = 'maga';
$dbUser = 'root';
// IMPORTANT: In a real production environment, this password should be stored securely,
// for example in an environment variable, not hardcoded in the source code.
$dbPass = '1948V10r12!';

// --- 2. Global Database Object ($dbo) Initialization ---
try {
    // Establish PDO connection
    $pdo = new PDO(
        "mysql:host={$dbHost};dbname={$dbName};charset=utf8mb4",
        $dbUser,
        $dbPass,
        [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION, // Throw exceptions on error
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,   // Fetch associative arrays by default
            PDO::ATTR_EMULATE_PREPARES   => false,              // Use native prepared statements
        ]
    );
} catch (PDOException $e) {
    // If connection fails, stop everything and show the error.
    die("FATAL ERROR: Database connection failed: " . $e->getMessage());
}

/**
 * A wrapper class to mimic the expected $dbo object behavior.
 * This makes the legacy update scripts compatible with our modern PDO connection.
 */
class DboWrapper
{
    private $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    /**
     * Executes a query (for INSERT, UPDATE, DELETE).
     * For SELECT statements, this will work but it's better to use fetchArray.
     * @param string $sql The SQL query to execute.
     * @return int The number of affected rows.
     */
    public function query(string $sql)
    {
        return $this->pdo->exec($sql);
    }

    /**
     * Executes a SELECT query and fetches all results into an associative array.
     * @param string $sql The SQL SELECT statement.
     * @return array The result set as an array of associative arrays.
     */
    public function fetchArray(string $sql): array
    {
        $stmt = $this->pdo->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Returns the ID of the last inserted row.
     * @return string The ID of the last inserted row.
     */
    public function lastInsertedID(): string
    {
        return $this->pdo->lastInsertId();
    }
    
    /**
     * Returns the underlying PDO object for advanced operations like transactions.
     * @return PDO
     */
    public function getPdo(): PDO
    {
        return $this->pdo;
    }
}

// Create the global $dbo object that the update scripts expect
$dbo = new DboWrapper($pdo);


// --- 3. Global Utility Functions ---

/**
 * Returns the absolute path to the project's root directory.
 * @return string
 */
function base_dir(): string
{
    // Since core.php is in the root, __DIR__ is the base directory.
    return __DIR__;
}

/**
 * Deletes a file or a directory recursively.
 * Handles arrays of paths as well.
 * @param string|array $path The path or an array of paths to delete.
 */
function delete($path)
{
    if (is_array($path)) {
        foreach ($path as $p) {
            delete($p); // Recursive call for array items
        }
        return;
    }

    if (!file_exists($path) && !is_link($path)) {
        // Silently fail if file does not exist, to match original behavior
        return;
    }

    if (is_file($path) || is_link($path)) {
        @unlink($path);
    } elseif (is_dir($path)) {
        // Use an iterator to recursively delete directory contents
        $files = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($path, RecursiveDirectoryIterator::SKIP_DOTS),
            RecursiveIteratorIterator::CHILD_FIRST
        );

        foreach ($files as $fileinfo) {
            $todo = ($fileinfo->isDir() ? 'rmdir' : 'unlink');
            @$todo($fileinfo->getRealPath());
        }
        @rmdir($path);
    }
}

// --- End of core.php --- 