const searchBox = document.getElementById('search-box');
const suggestionsBox = document.getElementById('suggestions');
let map = L.map('map').setView([50.8503, 4.3517], 13); // Bruxelles par défaut

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

let marker = null;

searchBox.addEventListener('input', async () => {
    const query = searchBox.value;
    if (query.length < 2) {
        suggestionsBox.innerHTML = '';
        return;
    }

    const response = await fetch(`/autocomplete?q=${encodeURIComponent(query)}`);
    const suggestions = await response.json();

    suggestionsBox.innerHTML = '';
    suggestions.forEach(addr => {
        const item = document.createElement('div');
        item.classList.add('suggestion-item');
        item.textContent = addr;
        item.addEventListener('click', () => {
            searchBox.value = addr;
            suggestionsBox.innerHTML = '';
            fetchAndShowLocation(addr);
        });
        suggestionsBox.appendChild(item);
    });
});

async function fetchAndShowLocation(address) {
    const response = await fetch(`/geocode?address=${encodeURIComponent(address)}`);
    const data = await response.json();

    if (data && data.lat && data.lon) {
        if (marker) map.removeLayer(marker);
        marker = L.marker([data.lat, data.lon]).addTo(map);

        const popupContent = `
            <strong>${address}</strong><br>
            Commune : ${data.commune}<br>
            Code postal : ${data.code_postal}<br>
            Epoque : ${data.époque}<br>
			De : ${data.min_nr}<br>
			à : ${data.max_nr}
        `;
        marker.bindPopup(popupContent).openPopup();
        map.setView([data.lat, data.lon], 16);
    }
}
