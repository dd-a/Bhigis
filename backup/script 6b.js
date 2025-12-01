// =======================
// Initialisation de la carte
// =======================
let map = L.map('map').setView([50.8503, 4.3517], 13); // Bruxelles
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

let marker = null;
let markers = [];

// =======================
// Générer une couleur dynamique (vert à rouge)
// =======================
function getColorFromEcart(ecart, minEcart) {
    const maxEcart = 20;
    const ratio = Math.min((ecart - minEcart) / maxEcart, 1);
    const r = Math.round(255 * ratio);
    const g = Math.round(180 * (1 - ratio));
    return `rgb(${r}, ${g}, 0)`;
}

// =======================
// Copier dans le presse-papiers avec retour visuel
// =======================
function copyToClipboardWithFeedback(text, button) {
    navigator.clipboard.writeText(text).then(() => {
        const originalText = button.innerHTML;
        button.innerHTML = '✅ Copié !';
        button.disabled = true;

        setTimeout(() => {
            button.innerHTML = originalText;
            button.disabled = false;
        }, 1500);
    }).catch(err => {
        console.error('Erreur lors de la copie :', err);
        alert("Échec de la copie.");
    });
}

// =======================
// Recherche principale
// =======================
async function search() {
    console.log("Recherche déclenchée");

    const street = document.getElementById('street').value;
    const number = document.getElementById('number').value;
    const year = document.getElementById('year').value;
    const commune = document.getElementById('commune').value;

    if (!street) {
        alert("Veuillez préciser au moins une rue.");
        return;
    }

    const params = new URLSearchParams({
        address: street,
        numero: number,
        annee: year,
        commune: commune
    });

    const response = await fetch(`/geocode?${params.toString()}`, { cache: 'no-store' });
    const data = await response.json();
    console.log("Résultats reçus :", data);
	
	const groupedByYear = {};  // transforme en dictionnaire par année 
	data.forEach(item => {
	    const year = item.époque ?? 'Inconnue';
	    if (!groupedByYear[year]) groupedByYear[year] = [];
	    groupedByYear[year].push(item);
	});

    // Nettoyage
    markers.forEach(m => map.removeLayer(m));
    markers = [];

    const resultsList = document.getElementById('results-list');
    resultsList.innerHTML = '';

    if (data.length === 0) {
        alert("Aucune adresse trouvée.");
        return;
    }

    const yearInput = parseInt(year);
    let minEcart = Infinity;

    data.forEach(item => {
        if (item.époque !== null && yearInput) {
            const ecart = Math.abs(item.époque - yearInput);
            if (ecart < minEcart) minEcart = ecart;
        }
    });

    // data.forEach((item, index) => {
    //     const ecart = Math.abs(item.époque - yearInput);
    //     const color = getColorFromEcart(ecart, minEcart);
    //
    //     const icon = L.divIcon({
    //         className: 'custom-div-icon',
    //         html: `<div style="background:${color};color:white;border-radius:50%;width:24px;height:24px;text-align:center;line-height:24px;">${index + 1}</div>`,
    //         iconSize: [24, 24],
    //         iconAnchor: [12, 12]
    //     });
    //
    //     const marker = L.marker([item.lat, item.lon], { icon }).addTo(map);
    //     markers.push(marker);
    //
    //     const popupContent = `
    //         <strong>${item.adresse} ${item.min_nr ?? ''}</strong><br>
    //         Commune : ${item.commune}<br>
    //         Code postal : ${item.code_postal}<br>
    //         Époque : ${item.époque}<br>
    //         Segment de rue : de ${item.min_nr} à ${item.max_nr}<br>
    //     `;
    //     marker.bindPopup(popupContent);
    //
    //     const listItem = document.createElement('li');
    //     listItem.style.padding = '10px';
    //     listItem.style.border = '1px solid #ddd';
    //     listItem.style.borderRadius = '6px';
    //     listItem.style.boxShadow = '0 1px 3px rgba(0,0,0,0.1)';
    //     listItem.style.background = ecart === minEcart ? '#e0f7fa' : '#fff';
    //     listItem.style.marginBottom = '8px';
    //     listItem.style.cursor = 'pointer';
    //     listItem.innerHTML = `
    //         <strong>${index + 1}.</strong> ${item.adresse} ${item.min_nr ?? ''} (${item.commune}, ${item.époque})
    //         <button title="Copier les coordonnées" class="copy-btn">📋</button>
    //     `;
    //
    //     // Hover style
    //     listItem.addEventListener('mouseover', () => {
    //         listItem.style.background = '#f9f9f9';
    //     });
    //     listItem.addEventListener('mouseout', () => {
    //         listItem.style.background = ecart === minEcart ? '#e0f7fa' : '#fff';
    //     });
    //
    //     // Centrage au clic
    //     listItem.addEventListener('click', () => {
    //         map.flyTo([item.lat, item.lon], 16, { duration: 0.8 });
    //         marker.openPopup();
    //     });
    //
    //     // Copier
    //     const copyBtn = listItem.querySelector('.copy-btn');
    //     copyBtn.addEventListener('click', (e) => {
    //         e.stopPropagation();
    //         copyToClipboardWithFeedback(`${item.lat}, ${item.lon}`, copyBtn);
    //     });
    //
    //     resultsList.appendChild(listItem);
    // });

	Object.keys(groupedByYear).sort().forEach(year => {
	    const yearGroup = groupedByYear[year];

	    // Créer un sous-titre par année
	    const yearHeader = document.createElement('h4');
	    yearHeader.textContent = `📅 ${year}`;
	    resultsList.appendChild(yearHeader);

	    yearGroup.forEach((item, index) => {
	        const ecart = Math.abs(item.époque - yearInput);
	        const color = getColorFromEcart(ecart, minEcart);

	        const icon = L.divIcon({
	            className: 'custom-div-icon',
	            html: `<div style="background:${color};color:white;border-radius:50%;width:24px;height:24px;text-align:center;line-height:24px;">${markers.length + 1}</div>`,
	            iconSize: [24, 24],
	            iconAnchor: [12, 12]
	        });

	        const marker = L.marker([item.lat, item.lon], { icon }).addTo(map);
	        markers.push(marker);

	        const popupContent = `
	            <strong>${item.adresse} ${item.min_nr ?? ''}</strong><br>
	            Commune : ${item.commune}<br>
	            Code postal : ${item.code_postal}<br>
	            Époque : ${item.époque}<br>
	            Segment de rue : de ${item.min_nr} à ${item.max_nr}<br>
	        `;
	        marker.bindPopup(popupContent);

	        const listItem = document.createElement('li');
	        listItem.style.padding = '10px';
	        listItem.style.border = '1px solid #ddd';
	        listItem.style.borderRadius = '6px';
	        listItem.style.boxShadow = '0 1px 3px rgba(0,0,0,0.1)';
	        listItem.style.background = ecart === minEcart ? '#e0f7fa' : '#fff';
	        listItem.style.marginBottom = '8px';
	        listItem.style.cursor = 'pointer';
	        listItem.innerHTML = `
	            <strong>${markers.length}.</strong> ${item.adresse} ${item.min_nr ?? ''} (${item.commune})
	            <button title="Copier les coordonnées" class="copy-btn">📋</button>
	        `;

	        listItem.addEventListener('mouseover', () => {
	            listItem.style.background = '#f9f9f9';
	        });
	        listItem.addEventListener('mouseout', () => {
	            listItem.style.background = ecart === minEcart ? '#e0f7fa' : '#fff';
	        });

	        listItem.addEventListener('click', () => {
	            map.flyTo([item.lat, item.lon], 16, { duration: 0.8 });
	            marker.openPopup();
	        });

	        const copyBtn = listItem.querySelector('.copy-btn');
	        copyBtn.addEventListener('click', (e) => {
	            e.stopPropagation();
	            copyToClipboardWithFeedback(`${item.lat}, ${item.lon}`, copyBtn);
	        });

	        resultsList.appendChild(listItem);
	    });
	});

    // Recentre la carte si plusieurs résultats
    if (markers.length > 1) {
        const group = L.featureGroup(markers);
        map.flyToBounds(group.getBounds().pad(0.2), {
            duration: 1.2
        });
    }
}

// =======================
// Initialisation
// =======================
document.addEventListener('DOMContentLoaded', () => {
    const searchBtn = document.getElementById('search-btn');
    if (searchBtn) {
        searchBtn.addEventListener('click', (e) => {
            e.preventDefault();
            search();
        });
    }
});