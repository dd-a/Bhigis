// =======================
// Initialisation de la carte
// =======================
let map = L.map('map').setView([50.8503, 4.3517], 13); // Bruxelles par défaut
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

let marker = null;
let markers = [];

// =======================
// Autocomplétion
// =======================
const searchBox = document.getElementById('search-box');
const suggestionsBox = document.getElementById('suggestions');

searchBox?.addEventListener('input', async () => {
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

// =======================
// Recherche simple (autocomplétion)
// =======================
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
            Époque : ${data.époque}<br>
            De : ${data.min_nr}<br>
            À : ${data.max_nr}
        `;
        marker.bindPopup(popupContent).openPopup();
        map.setView([data.lat, data.lon], 16);
    }
}

// =======================
// Recherche avancée (multi-résultats)
// =======================
async function search() {
    console.log("Recherche déclenchée");

    const street = document.getElementById('street').value;
    const number = document.getElementById('number').value;
    const year = document.getElementById('year').value;
	const commune = document.getElementById('commune').value;
	

    if (!street) {
        alert("Veuillez précisez au moins une rue.");
        return;
    }

	const params = new URLSearchParams({
	    address: street,
	    numero: number,
	    annee: year,
	    commune: commune
	});
    

	const response = await fetch(`/geocode?${params.toString()}`);
	const data = await response.json();
	console.log("Résultats reçus :", data);
    

    // Supprimer les anciens marqueurs
    markers.forEach(m => map.removeLayer(m));
    markers = [];
	
	const resultsList = document.getElementById('results-list');
	resultsList.innerHTML = '';
	

    if (data.length === 0) {
        alert("Aucune adresse trouvée.");
        return;
    }

	const yearInput = parseInt(document.getElementById('year').value);
	let minEcart = Infinity;

	data.forEach(item => {
	    if (item.époque !== null && yearInput) {
	        const ecart = Math.abs(item.époque - yearInput);
	        if (ecart < minEcart) minEcart = ecart;
	    }
	});

	data.forEach((item, index) => {
	    const icon = L.divIcon({
	        className: 'custom-div-icon',
	        html: `<div style="background:#2A81CB;color:white;border-radius:50%;width:24px;height:24px;text-align:center;line-height:24px;">${index + 1}</div>`,
	        iconSize: [24, 24],
	        iconAnchor: [12, 12]
	    });

	    const marker = L.marker([item.lat, item.lon], { icon }).addTo(map);
	    markers.push(marker);
		
		const ecart = Math.abs(item.époque - yearInput);
		if (ecart === minEcart) {
		    listItem.style.backgroundColor = '#e0f7fa'; // bleu clair
		}

	    const popupContent = `
	        <strong>${item.adresse} ${item.min_nr ?? ''}</strong><br>
	        Commune : ${item.commune}<br>
	        // Code postal : ${item.code_postal}<br>
	        Époque : ${item.époque}<br>
	        Segment de rue : de ${item.min_nr} à ${item.max_nr}<br>
	        
	    `;
	    marker.bindPopup(popupContent);

	    // Ajouter à la liste
	    const listItem = document.createElement('li');
		listItem.innerHTML = `<strong>${index + 1}.</strong> ${item.adresse} ${item.min_nr ?? ''} (${item.commune}, ${item.époque})`;
	    listItem.style.cursor = 'pointer';
	    listItem.style.marginBottom = '8px';
	    listItem.addEventListener('click', () => {
	        map.setView([item.lat, item.lon], 16);
	        marker.openPopup();
	    });
	    resultsList.appendChild(listItem);

	    if (index === 0) {
	        map.setView([item.lat, item.lon], 16);
	        marker.openPopup();
	    }
	});
    
}

// =======================
// Initialisation des événements
// =======================
document.addEventListener('DOMContentLoaded', () => {
    const searchBtn = document.getElementById('search-btn');
    if (searchBtn) {
        searchBtn.addEventListener('click', search);
    }
});
