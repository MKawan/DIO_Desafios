// Função para detectar a bandeira do cartão
function getCardType(number) {
    const num = number.replace(/\s/g, '');
    if (/^4/.test(num)) return 'Visa';
    if (/^5[1-5]/.test(num) || /^2[2-7]/.test(num)) return 'MasterCard';
    if (/^3[47]/.test(num)) return 'American Express';
    if (/^6(?:011|5)/.test(num)) return 'Discover';
    return 'Desconhecida';
}

// Função para formatar o número do cartão
function formatCardNumber(value) {
    const v = value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
    const matches = v.match(/\d{4,16}/g);
    const match = matches && matches[0] || '';
    const parts = [];
    for (let i = 0, len = match.length; i < len; i += 4) {
        parts.push(match.substring(i, i + 4));
    }
    if (parts.length) {
        return parts.join(' ');
    } else {
        return v;
    }
}

// Função para formatar a data de validade
function formatExpiry(value) {
    const v = value.replace(/\D/g, '');
    if (v.length >= 2) {
        return v.substring(0, 2) + '/' + v.substring(2, 4);
    }
    return v;
}

// Elementos do DOM
const cardNumberInput = document.getElementById('card-number-input');
const cardNameInput = document.getElementById('card-name-input');
const cardExpiryInput = document.getElementById('card-expiry-input');
const cardCvvInput = document.getElementById('card-cvv-input');

const cardType = document.getElementById('card-type');
const cardNumber = document.getElementById('card-number');
const cardName = document.getElementById('card-name');
const cardExpiry = document.getElementById('card-expiry');
const cardCvv = document.getElementById('card-cvv');

// Event listeners
cardNumberInput.addEventListener('input', function(e) {
    const formatted = formatCardNumber(e.target.value);
    e.target.value = formatted;
    cardNumber.textContent = formatted || '**** **** **** ****';
    cardType.textContent = getCardType(e.target.value);
});

cardNameInput.addEventListener('input', function(e) {
    cardName.textContent = e.target.value.toUpperCase() || 'NOME DO TITULAR';
});

cardExpiryInput.addEventListener('input', function(e) {
    const formatted = formatExpiry(e.target.value);
    e.target.value = formatted;
    cardExpiry.textContent = formatted || 'MM/YY';
});

cardCvvInput.addEventListener('input', function(e) {
    cardCvv.textContent = e.target.value || 'CVV';
});