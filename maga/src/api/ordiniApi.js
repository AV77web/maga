//==========================================
//File: ordiniApi.js
//Script che gestisce le chiamate http verso
//le api ordini (del back-end)
//di Express.
//@author: "villari.andrea@libero.it"
//@version: "1.0-0 2025-07-07"
//===========================================

import {createApiClient} from './apiClientFactory';

const ordiniApi = createApiClient('ordini');

export default ordiniApi;