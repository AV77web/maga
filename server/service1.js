//====================================
//Script per disinstallare il servizio
//Windows attivato con service.js
//@author: "villari.andrea@lobero.it"
//@versio: "1.0.0 2025-07-18"
//=================================

const { Service } = require('node-windows');
const path = require('path');

const svc = new Service({
  name: 'API Magazzino',
  description: 'API REST Node.js per la gestione del magazzino',
  script: path.join(__dirname, 'index.js')
});

svc.on('install', () => {
  console.log('✅ Servizio installato con successo.');
  svc.start();
});

svc.on('uninstall', () => {
  console.log('🗑️ Servizio disinstallato con successo.');
  console.log('Stato attuale:', svc.exists ? 'ANCORA PRESENTE' : 'NON PIÙ PRESENTE');
});

svc.on('alreadyinstalled', () => {
  console.log('⚠️ ATTENZIONE: Servizio già installato.');
});

svc.on('error', (err) => {
  console.error('🚨 Errore:', err);
});

const action = (process.argv[2] || '').toLowerCase();

if (['install'].includes(action)) {
  console.log('📦 Procedo con installazione...');
  svc.install();
} else if (['uninstall', 'unistall', 'remove', 'delete'].includes(action)) {
  console.log('🗑️ Procedo con disinstallazione...');
  svc.uninstall();
} else {
  console.log(`
❌ Nessuna azione valida.
Usa uno dei seguenti comandi:
  node service.js install    # Installa il servizio
  node service.js uninstall  # Disinstalla il servizio
`);
}