import React from 'react';
import { useNavigate } from 'react-router-dom';
import Ordini from '../components/Ordini';

export default function OrdersListPage(props){
  const nav = useNavigate();
  return (
    <Ordini
      {...props}
      onRowNavigate={(id)=>nav(`/ordini/${id}`)}
      onCreateNavigate={()=>nav('/ordini/new')}
    />
  );
}
