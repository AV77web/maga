const http = require('http');

const BASE_URL = 'http://localhost:3000/api/v1/orders';

function testOrdiniAPI() {
  console.log('🧪 Testando API Ordini...\n');

  const testCases = [
    { orderBy: 'id', expected: 'id_ordine' },
    { orderBy: 'num_ordine', expected: 'num_ordine' },
    { orderBy: 'data_ordine', expected: 'data_ordine' },
    { orderBy: 'rag_soc', expected: 'idanagrafica' },
    { orderBy: 'stato', expected: 'stato' },
    { orderBy: 'invalid_field', expected: 'id_ordine' },
  ];

  let currentTest = 0;

  function runNextTest() {
    if (currentTest >= testCases.length) {
      console.log('✅ Test completati!');
      return;
    }

    const testCase = testCases[currentTest];
    console.log(`📋 Testando orderBy: "${testCase.orderBy}" (dovrebbe mappare a "${testCase.expected}")`);
    
    const url = `${BASE_URL}?orderBy=${testCase.orderBy}&page=1&pageSize=5`;
    
    const req = http.get(url, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
      });
      
      res.on('end', () => {
        if (res.statusCode === 200) {
          console.log(`✅ SUCCESSO: API ha risposto correttamente per orderBy="${testCase.orderBy}"`);
          try {
            const response = JSON.parse(data);
            console.log(`   📊 Risultati: ${response.data?.length || 0} ordini trovati`);
          } catch (e) {
            console.log(`   📄 Response: ${data.substring(0, 100)}...`);
          }
        } else {
          console.log(`❌ ERRORE: Status ${res.statusCode} per orderBy="${testCase.orderBy}"`);
          console.log(`   📄 Response: ${data}`);
        }
        console.log('---');
        currentTest++;
        setTimeout(runNextTest, 1000); // Pausa tra i test
      });
    });

    req.on('error', (error) => {
      console.log(`❌ ERRORE: ${error.message} per orderBy="${testCase.orderBy}"`);
      console.log('---');
      currentTest++;
      setTimeout(runNextTest, 1000);
    });
  }

  runNextTest();
}

// Esegui il test
testOrdiniAPI(); 