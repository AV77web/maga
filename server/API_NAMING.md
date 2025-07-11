# API Naming & Commenting Conventions

Version: 1.0 – 2025-07-11

---

## 1. Base Path & Versioning

* All endpoints share the prefix

```
/api/v1/
```

Use semantic versioning for breaking changes: `/api/v2`, `/api/v3`, …

---

## 2. Resources

| Legacy Italian Name | New English Resource | Endpoint (plural, kebab-case) |
|--------------------|----------------------|------------------------------|
| ricambi            | parts                | `/parts`                     |
| fornitori          | suppliers            | `/suppliers`                 |
| clienti            | customers            | `/customers`                 |
| ordini             | orders               | `/orders`                    |
| movimenti          | movements            | `/movements`                 |
| causali            | causes               | `/causes`                    |
| diba (distinta base)| bom (bill-of-materials) | `/bom`                   |

> Rule: always use **English**, **plural**, **kebab-case** for path segments.

---

## 3. HTTP Verbs & Paths

| Action               | Verb | Path                                      | Notes                              |
|----------------------|------|-------------------------------------------|------------------------------------|
| list / filter        | GET  | `/resource?query=…`                       | supports `page`, `limit`           |
| retrieve             | GET  | `/resource/:id`                           | 404 if not found                   |
| create               | POST | `/resource`                               | returns `201 Created` + new id     |
| update (full)        | PUT  | `/resource/:id`                           | whole entity                       |
| update (partial)     | PATCH| `/resource/:id`                           | optional for partial updates       |
| delete               | DELETE| `/resource/:id`                          | 204 No Content                     |
| sub-collection       | GET  | `/orders/:orderId/items`                  | nested resources                   |

Avoid verbs in the path (`/getParts`, `/createSupplier`). The verb is the HTTP method.

---

## 4. Controller & Route Files

Structure per module:

```
server/modules/parts/
 ├─ parts.controller.js  // business logic
 └─ parts.routes.js      // express.Router()
```

Naming: `<resource>.controller.js`, `<resource>.routes.js`.

---

## 5. Comment Style (JSDoc)

Every exported controller function must have a JSDoc block:

```js
/**
 * GET /api/v1/parts
 * List parts with optional filters.
 * @param {Express.Request} req
 * @param {Express.Response} res
 * @param {Express.NextFunction} next
 */
```

Route files include a header:

```js
// routes/parts.routes.js – Parts endpoints
```

---

## 6. Status Codes

* `200 OK` – success with data
* `201 Created` – new resource created (return Location header when possible)
* `204 No Content` – successful delete or update with no body
* `400 Bad Request` – validation errors
* `401 Unauthorized` – missing/invalid token
* `403 Forbidden` – not enough privileges
* `404 Not Found` – resource missing
* `409 Conflict` – duplicates etc.
* `500 Internal Server Error` – unhandled

---

## 7. Pagination Parameters

| Param  | Default | Description          |
|--------|---------|----------------------|
| page   | 1       | 1-based index        |
| limit  | 50      | max rows per page    |

Backend returns:

```json
{
  "success": true,
  "data": [ … ],
  "pagination": { "page": 1, "limit": 50, "total": 123 }
}
```

---

## 8. Error Format

```json
{
  "success": false,
  "message": "Validation failed: name is required",
  "code": "VALIDATION_ERROR"
}
```

---

## 9. Deprecation Policy

Deprecated endpoints return header:

```
Deprecation: true
Link: <https://docs.example.com/v2>; rel="alternate"
```

and log a warning via `logger.warn()`. 