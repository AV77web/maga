# Sistema Dropdown

Questo sistema fornisce componenti modulari per creare menu dropdown personalizzabili e riutilizzabili.

## Componenti

### 1. Dropdown
Il componente principale che gestisce l'apertura/chiusura del menu.

**Props:**
- `trigger`: Elemento che attiva il dropdown
- `children`: Contenuto del dropdown
- `isOpen`: Stato di apertura
- `onToggle`: Callback per gestire l'apertura/chiusura
- `className`: Classi CSS aggiuntive
- `position`: Posizione del dropdown ('top', 'bottom', 'left', 'right')

### 2. DropdownContent
Contenitore per gli elementi del dropdown con header opzionale.

**Props:**
- `children`: Elementi del dropdown
- `className`: Classi CSS aggiuntive
- `title`: Titolo dell'header
- `showHeader`: Mostra/nasconde l'header
- `maxHeight`: Altezza massima del contenuto

### 3. DropdownItem
Elemento singolo del dropdown con supporto per diversi tipi.

**Props:**
- `children`: Contenuto dell'elemento
- `onClick`: Callback per il click
- `className`: Classi CSS aggiuntive
- `disabled`: Disabilita l'elemento
- `icon`: Icona da mostrare
- `type`: Tipo di elemento ('default', 'checkbox', 'radio', 'separator')
- `checked`: Stato per checkbox/radio
- `onCheckChange`: Callback per cambio stato checkbox

### 4. DropdownButton
Pulsante specializzato per trigger del dropdown.

**Props:**
- `children`: Testo del pulsante
- `onClick`: Callback per il click
- `isOpen`: Stato di apertura
- `disabled`: Disabilita il pulsante
- `className`: Classi CSS aggiuntive
- `icon`: Icona da mostrare
- `title`: Tooltip del pulsante

## Esempi di utilizzo

### Dropdown semplice
```jsx
<Dropdown
  trigger={<button>Apri menu</button>}
  isOpen={isOpen}
  onToggle={setIsOpen}
>
  <DropdownContent>
    <DropdownItem onClick={() => console.log("Opzione 1")}>
      Opzione 1
    </DropdownItem>
    <DropdownItem onClick={() => console.log("Opzione 2")}>
      Opzione 2
    </DropdownItem>
  </DropdownContent>
</Dropdown>
```

### Dropdown con checkbox
```jsx
<Dropdown
  trigger={<DropdownButton>Colonne</DropdownButton>}
  isOpen={isOpen}
  onToggle={setIsOpen}
>
  <DropdownContent title="Colonne visibili" showHeader={true}>
    <DropdownItem type="checkbox" checked={true}>
      Nome
    </DropdownItem>
    <DropdownItem type="checkbox" checked={false}>
      Email
    </DropdownItem>
  </DropdownContent>
</Dropdown>
```

### Dropdown con icone
```jsx
<Dropdown
  trigger={<DropdownButton icon={<FaUser />}>Menu utente</DropdownButton>}
  isOpen={isOpen}
  onToggle={setIsOpen}
>
  <DropdownContent title="Menu Utente" showHeader={true}>
    <DropdownItem icon={<FaUser />} onClick={handleProfile}>
      Profilo
    </DropdownItem>
    <DropdownItem icon={<FaCog />} onClick={handleSettings}>
      Impostazioni
    </DropdownItem>
  </DropdownContent>
</Dropdown>
```

## Caratteristiche

- **Responsive**: Si adatta automaticamente ai dispositivi mobili
- **Accessibile**: Supporta navigazione da tastiera e screen reader
- **Personalizzabile**: Stili CSS modulari e configurabili
- **Animazioni**: Transizioni fluide per apertura/chiusura
- **Click outside**: Si chiude automaticamente cliccando fuori
- **Posizionamento**: Supporta diverse posizioni (top, bottom, left, right)

## Stili CSS

Tutti i componenti includono file CSS separati con stili di base che possono essere personalizzati:

- `Dropdown.css`: Stili per il container e posizionamento
- `DropdownContent.css`: Stili per il contenuto e header
- `DropdownItem.css`: Stili per gli elementi del menu
- `DropdownButton.css`: Stili per il pulsante trigger

## Integrazione con ArticoliTable

Il sistema è stato integrato in `ArticoliTable.jsx` per gestire la visualizzazione/nascondimento delle colonne della tabella attraverso il componente `ColumnVisibilityMenu`. 