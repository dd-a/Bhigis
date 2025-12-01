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
        alert("Il nous faut au moins un nom de rue !");
        return;
    }

    const params = new URLSearchParams({
        address: street,
        numero: number,
        annee: year,
        commune: commune
    });

    const response = await fetch(`/geocode?${params.toString()}`, { cache: 'no-store' });
	// const feedback = document.getElementById('feedback-message');
	// if (feedback) {
	//     feedback.textContent = "Requête envoyée au serveur...";
	// }
    const data = await response.json();
    console.log("Résultats reçus :", data);
		// Afficher confirmation temporaire
	const feedback = document.getElementById('feedback-message');
	if (feedback) {
	    feedback.textContent = "Voilà ✅";
	    setTimeout(() => {
	        feedback.textContent = "";
	    }, 3000);
	}
	console.log("Exemple résultat :", data[0]);
	
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

	// Tri : best_answer en premier
	data.sort((a, b) => {
	    if (a.best_answer && !b.best_answer) return -1;
	    if (!a.best_answer && b.best_answer) return 1;
	    return 0;
	});

	// Calcul du min pour dist_muni (évite division par 0)
	const maxDist = Math.max(...data.map(d => d.dist_muni ?? 0), 1);

	data.forEach((item, index) => {
	    const isBest = item.best_answer === true;
	    const dist = item.dist_muni ?? 0;

	    // Couleur du marqueur : vert si best, sinon rouge + intensité
	    const color = isBest
	        ? '#4CAF50' // vert
	        : `rgb(${Math.min(255, 50 + 10 * dist)}, 0, 0)`; // rouge plus ou moins foncé

	    const icon = L.divIcon({
	        className: 'custom-div-icon',
	        html: `<div style="background:${color};color:white;border-radius:50%;width:24px;height:24px;text-align:center;line-height:24px;">${index + 1}</div>`,
	        iconSize: [24, 24],
	        iconAnchor: [12, 12]
	    });

	    const marker = L.marker([item.lat, item.lon], { icon }).addTo(map);
	    markers.push(marker);

	    const popupContent = ``
	        <strong>${item.adresse ?? '(adresse inconnue)'}</strong><br>
	        Commune : ${item.commune}<br>
	        Époque : ${item.époque ?? 'n.c.'}<br>
	        Similarité du nom : ${(item.simila * 100).toFixed(1)} %<br>
	        ${item.dist_muni !== null ? `Éloignement à la commune recherchée : ${item.dist_muni} m` : ''}
	    `;
	    marker.bindPopup(popupContent);

	    const listItem = document.createElement('li');
	    listItem.style.padding = '10px';
	    listItem.style.border = '1px solid #ddd';
	    listItem.style.borderRadius = '6px';
	    listItem.style.boxShadow = '0 1px 3px rgba(0,0,0,0.1)';
	    listItem.style.background = isBest ? '#e0fbe0' : '#fff';
	    listItem.style.marginBottom = '8px';
	    listItem.style.cursor = 'pointer';

	    listItem.innerHTML = `
	        <strong>${index + 1}.</strong> ${item.adresse} (${item.commune}, ${item.époque ?? 'n.c.'})
	        ${isBest ? '<span style="color:green;font-weight:bold;margin-left:8px;">✓ Meilleure correspondance</span>' : ''}
	        <br><small>Estimation de la similarité des noms : ${(item.simila * 100).toFixed(1)}%</small>
	        <button title="Copier les coordonnées" class="copy-btn" style="margin-left:10px;">📋</button>
	    `;

	    listItem.addEventListener('mouseover', () => {
	        listItem.style.background = '#f9f9f9';
	    });
	    listItem.addEventListener('mouseout', () => {
	        listItem.style.background = isBest ? '#e0fbe0' : '#fff';
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
	// });

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

