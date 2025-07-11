# React + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh

## Expanding the ESLint configuration

If you are developing a production application, we recommend using TypeScript with type-aware lint rules enabled. Check out the [TS template](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-react-ts) for information on how to integrate TypeScript and [`typescript-eslint`](https://typescript-eslint.io) in your project.

## Backend (Express) – Server directory

Il backend Node/Express si trova in `server/` ed espone le API REST.

### Requisiti
1. Node 18+
2. MySQL / MariaDB configurato con uno schema chiamato `maga`
3. File `.env` (non tracciato) nella cartella `server/`

### Variabili ambiente (anche in `.env.example`)
| Chiave | Descrizione | Default |
| ------ | ----------- | ------- |
| `PORT` | Porta di ascolto Express | `3001` |
| `NODE_ENV` | `development` \| `production` | `development` |
| `LOG_LEVEL` | Livello minimo dei log Pino (`trace`, `debug`, `info`, `warn`, `error`, `fatal`) | `info` |
| `FRONTEND_ORIGIN` | Origine consentita dal CORS (es. `http://localhost:5173`) | _vuoto_ |
| `JWT_SECRET` | Chiave segreta per firmare i token JWT | _vuoto_ |
| `DB_HOST` | Host del database | `localhost` |
| `DB_USER` | Utente del database | `root` |
| `DB_PASSWORD` | Password del database | _vuoto_ |
| `DB_DATABASE` | Nome del database | `maga` |

Copia `server/.env.example` in `server/.env` e personalizza i valori.

### Logging con Pino
- In **sviluppo** i log sono formattati in chiaro via `pino-pretty`.
- In **produzione** vengono emessi JSON (aggregabili da servizi come Loki, Elastic, Papertrail).
- Livello configurabile con `LOG_LEVEL`.

### Sicurezza
- Header di sicurezza tramite `helmet`.
- Rate-limiting di base: 100 richieste ogni 15 minuti per IP (vedi `server/index.js`).
- Autenticazione JWT con middleware `authenticateToken` e controllo ruoli `isAdmin`.

### Script utili
Da `server/`:

```bash
# Avvio in hot-reload (nodemon)
npm run dev

# Avvio production-like
NODE_ENV=production node index.js
```

### Struttura principali
```
server/
 ├─ index.js            # entrypoint Express
 ├─ utils/logger.js     # istanza pino
 ├─ controllers/        # logica API
 ├─ routes/             # definizione endpoint
 ├─ middleware/         # auth, ruoli, error handler
 └─ db/                 # pool MySQL (mysql2)
```

> Nota: La rotta di fallback `POST /api/movimenti/customquery` è protetta da `isAdmin` ma va disabilitata in produzione perché esegue SQL arbitrario.
