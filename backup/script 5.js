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
// Fonction pour colorer les pastilles (vert → rouge)
// =======================
function getColorFromEcart(ecart, minEcart) {
    const maxEcart = 20; // tolérance maximum pour rouge
    const ratio = Math.min((ecart - minEcart) / maxEcart, 1); // entre 0 et 1
    const r = Math.round(255 * ratio);
    const g = Math.round(180 * (1 - ratio));
    return `rgb(${r}, ${g}, 0)`; // orange/rouge/vert
}

// =======================
// Copie avec feedback
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
// Recherche avancée (multi-résultats)
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

    // Supprimer les anciens marqueurs
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

    data.forEach((item, index) => {
        const ecart = Math.abs(item.époque - yearInput);
        const color = getColorFromEcart(ecart, minEcart);

        const icon = L.divIcon({
            className: 'custom-div-icon',
            html: `<div style="background:${color};color:white;border-radius:50%;width:24px;height:24px;text-align:center;line-height:24px;">${index + 1}</div>`,
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
        if (ecart === minEcart) {
            listItem.style.backgroundColor = '#e0f7fa';
        }

        listItem.innerHTML = `
            <strong>${index + 1}.</strong> ${item.adresse} ${item.min_nr ?? ''} (${item.commune}, ${item.époque})
            <button title="Copier les coordonnées" class="copy-btn">📋</button>
        `;
        listItem.style.cursor = 'pointer';
        listItem.style.marginBottom = '8px';
		listItem.addEventListener('click', () => {
		    map.flyTo([item.lat, item.lon], 16, {
		        duration: 0.8 // animation douce
		    });
		    marker.openPopup();
		});
		
		listItem.style.padding = '10px';
		listItem.style.border = '1px solid #ddd';
		listItem.style.borderRadius = '6px';
		listItem.style.boxShadow = '0 1px 3px rgba(0,0,0,0.1)';
		listItem.style.background = '#fff';
		listItem.style.transition = 'background 0.3s';
		listItem.addEventListener('mouseover', () => {
		    listItem.style.background = '#f9f9f9';
		});
		listItem.addEventListener('mouseout', () => {
		    listItem.style.background = ecart === minEcart ? '#e0f7fa' : '#fff';
		});

        // gestion du bouton copier
        const copyBtn = listItem.querySelector('.copy-btn');
        copyBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            copyToClipboardWithFeedback(`${item.lat}, ${item.lon}`, copyBtn);
        });

        resultsList.appendChild(listItem);
		
		if (markers.length > 1) {
		    const group = L.featureGroup(markers);
		    map.flyToBounds(group.getBounds().pad(0.2), {
		        duration: 1.2 // en secondes (animation douce)
		    });
		}

        if (index === 0) {
            map.setView([item.lat, item.lon], 16);
            marker.openPopup();
        }
	});

	if (markers.length > 1) {
	    const group = L.featureGroup(markers);
	    map.fitBounds(group.getBounds().pad(0.2));
	}
}

// =======================
// Initialisation des événements
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