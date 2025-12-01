
// =======================
// Initialisation de la carte
// =======================
let map = L.map('map', {
    minZoom: 10,
    maxZoom: 18  // ← c'est ici qu'on autorise un zoom très précis
}).setView([50.8503, 4.3517], 13); // Bruxelles
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

let marker = null;
let markers = [];

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
		console.error("Erreur :", error);
		alert(translations.fetch_error);
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
    const data = await response.json();
	//console.log("Données reçues :", data); // Vérifiez les données ici
    document.getElementById('results-area').style.display = 'block';
	map.invalidateSize();

    const feedback = document.getElementById('feedback-message');
    if (feedback) {
        feedback.textContent = "Voilà ✅";
        setTimeout(() => {
            feedback.textContent = "";
        }, 3000);
    }

    console.log("Données reçues :", data);
    if (data.length === 0) {
        alert("Aucune adresse trouvée.");
        return;
    }

    markers.forEach(m => map.removeLayer(m));
    markers = [];

    const resultsList = document.getElementById('results-list');
    resultsList.innerHTML = '';

    data.sort((a, b) => {
        if (a.best_answer && !b.best_answer) return -1;
        if (!a.best_answer && b.best_answer) return 1;
        return 0;
    });

    const maxDist = Math.max(...data.map(d => d.dist_muni ?? 0), 1);

	// === 1. Marqueurs sur la carte (ordre inversé, mais bon numéro) ===
	data.slice().reverse().forEach((item, reversedIndex) => {
	    const index = data.length - 1 - reversedIndex; // bon index logique

	    const isBest = item.best_answer === true;
	    const dist = item.dist_muni ?? 0;

	    let color = '#4CAF50';
	    let textColor = 'white';

		if (!isBest) {
		    const sim = item.simila ?? 0;

		    // Échelle inversée : 1.0 → jaune, 0.25 → rouge
		    const ratio = Math.min(Math.max((sim - 0.25) / (1.0 - 0.25), 0), 1);

		    const r = 225;
		    const g = Math.round(225 * ratio); // 0 = rouge, 1 = jaune

		    color = `rgb(${r}, ${g}, 0)`;
		    textColor = (g > 150) ? 'black' : 'white';
		}

	    const icon = L.divIcon({
	        className: 'custom-div-icon',
	        html: `<div style="
	            background-color: ${color};
	            color: ${textColor};
	            border: 1.5px solid #660500;
	            border-radius: 50%;
	            width: 24px;
	            height: 24px;
	            text-align: center;
	            line-height: 24px;
	            opacity: 0.70;
	            font-weight: bold;
	            font-size: 13px;">
	            ${index + 1}
	        </div>`,
	        iconSize: [24, 24],
	        iconAnchor: [12, 12]
	    });

	    const marker = L.marker([item.lat, item.lon], { icon }).addTo(map);

		//  Ne crée la ligne que si main_name existe et n'est pas null/undefined/vid (grâce au '?')
		const mainNameLine = item.main_name ? `Nom réel : ${item.main_name}<br>` : '';


	    marker.bindPopup(`
	        <strong>${item.adresse ?? translations.unknown_address}</strong><br>
			${mainNameLine}
			${translations.epoch_label} : ${item.époque ?? 'n.c.'}<br>
		    ${translations.similarity_lb} : ${(item.simila * 100).toFixed(1)} %<br>
		    ${item.dist_muni !== null ? `${translations.dist_to_commune} : ${item.dist_muni} km` : ''}
	    `);
	    markers[index] = marker;
	});

    data.forEach((item, index) => {
        const isBest = item.best_answer === true;

        const listItem = document.createElement('li');
        listItem.style.padding = '10px';
        listItem.style.border = '1px solid #ddd';
        listItem.style.borderRadius = '6px';
        listItem.style.boxShadow = '0 1px 3px rgba(0,0,0,0.1)';
        listItem.style.background = isBest ? '#e0fbe0' : '#fff';
        listItem.style.marginBottom = '8px';
        listItem.style.cursor = 'pointer';

        listItem.innerHTML = `
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <strong>${index + 1}.</strong> ${item.adresse} (${item.commune}, ${item.époque ?? 'n.c.'})
                    ${isBest ? `<span style="background-color:green;color:white;padding:2px 6px;border-radius:4px;margin-left:8px;">${translations.best_result}</span>` : ''}
                </div>
                <button title="${translations.copy_latlon}" class="copy-btn" style="
                    background: none;
                    border: none;
                    font-size: 20px;
                    cursor: pointer;
                    margin-left: 10px;
                ">🌍</button>
            </div>
            <div style="margin-top: 4px;">
                <small style="color: #333;">
                    ${item.simila !== undefined && item.simila !== null
						? `${translations.similarity_lb} : ${(item.simila * 100).toFixed(1)}%`
		                : translations.similarity_na}
                </small>
            </div>
        `;

        listItem.addEventListener('mouseover', () => {
            listItem.style.background = '#f9f9f9';
        });
        listItem.addEventListener('mouseout', () => {
            listItem.style.background = isBest ? '#e0fbe0' : '#fff';
        });

        listItem.addEventListener('click', () => {
            map.flyTo([item.lat, item.lon], 16, { duration: 0.8 });
            markers[index].openPopup();
        });

        const copyBtn = listItem.querySelector('.copy-btn');
        copyBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            copyToClipboardWithFeedback(`${item.lat}, ${item.lon}`, copyBtn);
        });

        resultsList.appendChild(listItem);
    });

	 if (markers.length > 1) {
		 map.invalidateSize();
	     map.setView([50.8467, 4.3499], 12);  // Zoom fixe sur Bruxelles
	 } else if (markers.length === 1) {
		 map.invalidateSize();
	     map.flyTo(markers[0].getLatLng(), 16, { duration: 1.2 });
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
