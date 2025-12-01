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

let markers = [];

async function search() {
	console.log("Recherche déclenchée");
    const street = document.getElementById('street').value;
    const number = document.getElementById('number').value;
    const year = document.getElementById('year').value;

    if (!street) {
        alert("Veuillez entrer une rue.");
        return;
    }

    const params = new URLSearchParams({
        address: street,
        numero: number,
        annee: year
    });

    const response = await fetch(`/geocode?${params.toString()}`);
    const data = await response.json();

    // Supprimer les anciens marqueurs
    markers.forEach(m => map.removeLayer(m));
    markers = [];

    if (data.length === 0) {
        alert("Aucune adresse trouvée.");
        return;
    }

    data.forEach((item, index) => {
        const icon = L.divIcon({
            className: 'custom-div-icon',
            html: `<div style="background:#2A81CB;color:white;border-radius:50%;width:24px;height:24px;text-align:center;line-height:24px;">${index + 1}</div>`,
            iconSize: [24, 24],
            iconAnchor: [12, 12]
        });

        const marker = L.marker([item.lat, item.lon], { icon }).addTo(map);
        markers.push(marker);

        const popupContent = `
            <strong>${item.adresse} ${number}</strong><br>
            Commune : ${item.commune}<br>
            Code postal : ${item.code_postal}<br>
            Époque : ${item.époque}<br>
            De : ${item.min_nr}<br>
            À : ${item.max_nr}
        `;
        marker.bindPopup(popupContent);

        if (index === 0) {
            map.setView([item.lat, item.lon], 16);
            marker.openPopup();
        }
    });
}

