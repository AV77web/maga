//===========================================
// File: OrderDetailPage.jsx
// Componente che gestisce la pagins di dettaglio 
// degli ordini
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-15"
//=============================================
import  React, {useState} from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import DocumentHeaderForm from '../components/DocumentHeaderForm';
import orderSchema      from '#schemas/order.schema.json';
import { orderUiHints } from '../uiHints/orderUiHints';
import Header           from '../components/Header';
import useOrder         from '../hooks/useOrder';

export default function OrderDetailPage({ currentUser, onLogout }) {
  const { orderId } = useParams();          // 'new' oppure numero
  const isNew   = orderId === 'new';
  const nav     = useNavigate();

  /* ------------ Hook custom per fetch/salva ------------ */
  const { orderHead, orderLines, saveHead } = useOrder(isNew ? null : Number(orderId));

  /* ------------ Draft state ------------ */
  const [draftHead, setDraftHead] = useState(orderHead.data || {});
  // righe: potrai gestirle a parte

  /* ------------ Handlers ------------ */
  const handleSave = async () => {
    await saveHead.mutateAsync(draftHead);
    nav('/ordini');          // torni alla lista
  };

  return (
    <>
      <Header
        onBack={() => nav('/ordini')}
        onSave={handleSave}
        currentUser={currentUser}
        onLogout={onLogout}
      />
      <div className="container">
        <DocumentHeaderForm
          schema={orderSchema}
          uiHints={orderUiHints}
          initialData={draftHead}
          readOnly={false}
          onChange={setDraftHead}
        />
        {/* TODO: aggiungi OrderLinesTable qui */}
      </div>
    </>
  );
}

