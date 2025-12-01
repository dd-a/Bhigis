// =========================
// 1. Upload du fichier -> analyse colonnes
// =========================
document.getElementById("fileInput").addEventListener("change", function (event) {
    const file = event.target.files[0];
    if (!file) return;

    document.getElementById("status").innerText = "Fichier sélectionné : " + file.name;

    analyzeFile(file);
});

function analyzeFile(file) {
    const formData = new FormData();
    formData.append("file", file);

    fetch("/analyze_file", {
        method: "POST",
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                document.getElementById("status").innerText = "Erreur : " + data.error;
            } else {
                showColumnMapping(data.file_columns, data.db_columns);
                // stocker le nom du fichier pour l’envoi final
                window.selectedFile = file;
            }
        })
        .catch(error => {
            console.error("Erreur analyse fichier :", error);
            document.getElementById("status").innerText = "Erreur lors de l'analyse du fichier.";
        });
}

// =========================
// 2. Affichage du mapping
// =========================
function normalizeString(str) {
    return str
        .normalize("NFD")                // décompose les lettres accentuées
        .replace(/[\u0300-\u036f]/g, "") // supprime les diacritiques (accents)
        .toLowerCase();                  // ignore la casse
}

function showColumnMapping(fileColumns, dbColumns) {
    const mappingDiv = document.getElementById("column-mapping");
    mappingDiv.innerHTML = "<h3>2. Associez les colonnes :</h3>";

    dbColumns.forEach(dbCol => {
        // Cherche un équivalent direct (insensible à la casse)
        const autoMatch = fileColumns.find(fc => normalizeString(fc) === normalizeString(dbCol));

        const select = document.createElement("select");
        select.name = dbCol;

        // Option vide (par défaut si aucun match)
        const emptyOption = document.createElement("option");
        emptyOption.value = "";
        emptyOption.textContent = "-- choisir --";
        select.appendChild(emptyOption);

        // Ajout des options possibles
        fileColumns.forEach(fc => {
            const option = document.createElement("option");
            option.value = fc;
            option.textContent = fc;

            // Si on a trouvé une correspondance automatique → on pré-sélectionne
            if (autoMatch && fc === autoMatch) {
                option.selected = true;
            }

            select.appendChild(option);
        });

        const label = document.createElement("label");
        label.textContent = dbCol + " → ";
        label.appendChild(select);

        mappingDiv.appendChild(label);
        mappingDiv.appendChild(document.createElement("br"));
    });

    // Afficher le bouton de validation du mapping
    document.getElementById("submitMapping").style.display = "inline-block";
}

// =========================
// 3. Envoi fichier + mapping vers /batch_geocode
// =========================
// click handler du bouton submitMapping (ou code équivalent)
document.getElementById("submitMapping").addEventListener("click", async function () {
    if (!window.selectedFile) {
        alert("Aucun fichier sélectionné.");
        return;
    }

    const selects = document.querySelectorAll("#column-mapping select");
    const mapping = {};
    selects.forEach(select => {
        if (select.value) mapping[select.name] = select.value;
    });

    const formData = new FormData();
    formData.append("file", window.selectedFile);
    formData.append("mapping", JSON.stringify(mapping));

    const statusEl = document.getElementById("status");
    statusEl.innerText = "Fichier en cours de traitement...";

    try {
        const response = await fetch("/batch_geocode", {
            method: "POST",
            body: formData
        });

        // Si tout va bien on attend un blob (zip)
        if (response.ok) {
            const blob = await response.blob();
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement("a");
            a.href = url;
            // nom avec timestamp
            const ts = new Date().toISOString().replace(/[-:T]/g, "").split(".")[0];
            a.download = `resultats_bhigis_${ts}.zip`;
            document.body.appendChild(a);
            a.click();
            a.remove();
            window.URL.revokeObjectURL(url);
            statusEl.innerText = "Traitement terminé, fichier téléchargé.";
            return;
        }

        // ---- réponse d'erreur (response.ok == false) ----
        // Essaie d'abord JSON (si backend renvoie {error: "..."})
        let errText = "";
        const ct = response.headers.get("content-type") || "";
        if (ct.includes("application/json")) {
            const errJson = await response.json();
            // peut contenir {error: "..."} ou {message: "..."}
            errText = errJson.error || errJson.message || JSON.stringify(errJson);
        } else {
            // sinon lis le texte brut
            errText = await response.text();
        }

        console.error("Erreur serveur :", response.status, errText);
        statusEl.innerText = `Erreur lors du traitement (${response.status}) : ${errText}`;

    } catch (err) {
        console.error("Erreur lors du traitement :", err);
        statusEl.innerText = "Erreur réseau ou inattendue lors du traitement.";
    }
});