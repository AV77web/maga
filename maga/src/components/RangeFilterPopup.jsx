import React, { useState, useEffect, useRef } from "react";

const popupStyle = {
    position: 'absolute',
    zIndex: 1000,
    background: '#fff',
    border: '1px solid #e0e0e0',
    borderRadius: 12,
    boxShadow: '0 4px 24px rgba(0,0,0,0.12)',
    padding: 20,
    minWidth: 260,
    fontFamily: 'Segoe UI, Arial, sans-serif',
    color: '#222',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'stretch',
};

const articoloGridStyle = {
    display: 'grid',
    gridTemplateColumns: 'repeat(4, 1fr)',
    gap: '12px',
    marginBottom: 8,
};

const articoloFieldStyle = {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'stretch',
    minWidth: 0,
};

const labelStyle = {
    display: 'block',
    fontSize: 13,
    color: '#555',
    marginBottom: 2,
    fontWeight: 500,
};

const inputStyle = {
    width: '100%',
    padding: '6px 8px',
    fontSize: 15,
    border: '1px solid #bdbdbd',
    borderRadius: 6,
    outline: 'none',
    marginBottom: 0,
    background: '#fafafa',
    transition: 'border 0.2s',
};

const inputStyleFocus = {
    border: '1.5px solid #1976d2',
    background: '#fff',
};

const buttonRowStyle = {
    display: 'flex',
    gap: 12,
    justifyContent: 'flex-end',
    marginTop: 8,
};

const buttonStyle = {
    padding: '7px 18px',
    fontSize: 15,
    borderRadius: 6,
    border: 'none',
    cursor: 'pointer',
    background: '#1976d2',
    color: '#fff',
    fontWeight: 500,
    transition: 'background 0.2s',
};

const buttonCancelStyle = {
    ...buttonStyle,
    background: '#e0e0e0',
    color: '#333',
};

const RangeFilterPopup = ({ open, center, type, value, onClose, onApply }) => {
    const popupRef = useRef();
    const [focus, setFocus] = useState('');

    const defaultArticoloValue = [
        { from: '', to: '' },
        { from: '', to: '' },
        { from: '', to: '' },
        { from: '', to: '' }
    ];

    const [articoloRange, setArticoloRange] = useState(defaultArticoloValue);
    const [from, setFrom] = useState('');
    const [to, setTo] = useState('');

    useEffect(() => {
        if (!open) return;
        if (type === 'articolo') {
            setArticoloRange(value?.length === 4 ? value : defaultArticoloValue);
        } else {
            setFrom(value?.from || '');
            setTo(value?.to || '');
        }
    }, [open, value, type]);

    useEffect(() => {
        function handleClickOutside(event) {
            if (popupRef.current && !popupRef.current.contains(event.target) && open) {
                onClose();
            }
        }
        document.addEventListener("mousedown", handleClickOutside);
        return () => document.removeEventListener("mousedown", handleClickOutside);
    }, [open, onClose]);

    if (!open || !center) return null;

    // Popup più largo e basso per articolo
    const width = type === 'articolo' ? 600 : (popupStyle.minWidth || 260);
    const height = type === 'articolo' ? 120 : 180;
    const style = {
        ...popupStyle,
        minWidth: width,
        width,
        left: `calc(${center.x}px - ${width / 2}px)`,
        top: `calc(${center.y}px - ${height / 2}px)`,
    };

    const handleArticoloChange = (index, field, val) => {
        const updated = [...articoloRange];
        updated[index][field] = val;
        setArticoloRange(updated);
    };

    const handleConfirm = () => {
        if (type === 'articolo') {
            const updated = articoloRange.map((r, i) => ({
                from: r.from !== '' ? r.from : value?.[i]?.from || '',
                to: r.to !== '' ? r.to : value?.[i]?.to || '',
            }));

            // Notifica sempre il parent, anche se tutti i campi sono vuoti (reset)
            onApply(updated);
            onClose();
            return;
        }

        // Standard (number/date)
        if (from === '' && to === '') {
            onApply({ from: '', to: '' });
            onClose();
            return;
        }
        onApply({ from, to });
        onClose();
    };

    const renderStandardFields = () => (
        <>
            <div>
                <label style={labelStyle}>Da:</label>
                <input
                    type={type === 'date' ? 'date' : 'number'}
                    value={from}
                    onChange={e => setFrom(e.target.value)}
                    style={focus === 'from' ? { ...inputStyle, ...inputStyleFocus } : inputStyle}
                    onFocus={() => setFocus('from')}
                    onBlur={() => setFocus('')}
                />
            </div>
            <div>
                <label style={labelStyle}>A:</label>
                <input
                    type={type === 'date' ? 'date' : 'number'}
                    value={to}
                    onChange={e => setTo(e.target.value)}
                    style={focus === 'to' ? { ...inputStyle, ...inputStyleFocus } : inputStyle}
                    onFocus={() => setFocus('to')}
                    onBlur={() => setFocus('')}
                />
            </div>
        </>
    );

    const renderArticoloFields = () => {
        const labels = ['Larghezza', 'Altezza', 'Lunghezza', 'Spessore'];
        return (
            <div style={articoloGridStyle}>
                {labels.map((label, i) => (
                    <div key={i} style={articoloFieldStyle}>
                        <label style={labelStyle}>{label}</label>
                        <input
                            type="number"
                            placeholder="Da"
                            value={articoloRange[i].from}
                            onChange={e => handleArticoloChange(i, 'from', e.target.value)}
                            style={focus === `from-${i}` ? { ...inputStyle, ...inputStyleFocus } : inputStyle}
                            onFocus={() => setFocus(`from-${i}`)}
                            onBlur={() => setFocus('')}
                        />
                        <input
                            type="number"
                            placeholder="A"
                            value={articoloRange[i].to}
                            onChange={e => handleArticoloChange(i, 'to', e.target.value)}
                            style={focus === `to-${i}` ? { ...inputStyle, ...inputStyleFocus } : inputStyle}
                            onFocus={() => setFocus(`to-${i}`)}
                            onBlur={() => setFocus('')}
                        />
                    </div>
                ))}
            </div>
        );
    };

    return (
        <div ref={popupRef} style={style}>
            {type === 'articolo' ? renderArticoloFields() : renderStandardFields()}
            <div style={buttonRowStyle}>
                <button
                    style={buttonStyle}
                    onClick={handleConfirm}
                    onMouseOver={e => e.currentTarget.style.background = '#1565c0'}
                    onMouseOut={e => e.currentTarget.style.background = '#1976d2'}
                >
                    Conferma
                </button>
                <button
                    style={buttonCancelStyle}
                    onClick={onClose}
                    onMouseOver={e => e.currentTarget.style.background = '#bdbdbd'}
                    onMouseOut={e => e.currentTarget.style.background = '#e0e0e0'}
                >
                    Annulla
                </button>
            </div>
        </div>
    );
};

export default RangeFilterPopup;