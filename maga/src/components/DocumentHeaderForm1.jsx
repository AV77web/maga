//=======================================
// File: OrderHeaderForm.jsx
// Componente che gestisce il form per la gestione degli ordini
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-15"
//=======================================

// OrderHeaderForm.jsx   (ex HeadDocument2)
import { useForm } from 'react-hook-form';
import { ajvResolver } from '@hookform/resolvers/ajv';
import addFormats from 'ajv-formats';
import Ajv from 'ajv';

import orderSchema from '#schemas/order.schema.json';

const ajv = new Ajv({ allErrors: true, coerceTypes: true });
addFormats(ajv);                         // ISO-date, email, ecc.

const {
  control,
  handleSubmit,
  watch,
  formState: { errors },
} = useForm({
  resolver: ajvResolver(orderSchema, undefined, undefined, { ajv }),
  defaultValues: mapSchemaDefaults(orderSchema),     // funzione helper
});

function buildFieldConfig(schema){
  return Object.entries(schema.properties).map(([name,prop])=>{
    const base = { name, label: prop.title || name };

    if(prop.enum)        return { ...base, type: 'select', options: prop.enum };
    if(prop.format==='date')   return { ...base, type: 'date' };
    if(prop.type==='integer'||prop.type==='number')
                          return { ...base, type:'number', max:prop.maximum };
    return { ...base, type:'text', maxLength:prop.maxLength };
  });
}

const fieldConfig = useMemo(()=>buildFieldConfig(orderSchema),[]);