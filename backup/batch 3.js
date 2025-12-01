// ===============================
// batch.js
// ===============================

// Stocke le mapping utilisateur
let columnMapping = {};

// Gestion du fichier sélectionné
document.getElementById("fileInput").addEventListener("change", function (event) {
    const file = event.target.files[0];
    if (file) {
        document.getElementById("status").innerText = "Fichier sélectionné : " + file.name;
        analyzeFile(file);
    }
});

// Étape 1 : analyse du fichier (envoi vers /analyze_file)
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
        }
    })
    .catch(error => {
        console.error("Erreur analyse fichier :", error);
        document.getElementById("status").innerText = "Erreur lors de l'analyse du fichier.";
    });
}

// Étape 2 : affichage des dropdowns de mapping
function showColumnMapping(fileColumns, dbColumns) {
    const mappingDiv = document.getElementById("column-mapping");
    mappingDiv.innerHTML = "<h3>Associez les colonnes :</h3>";

    dbColumns.forEach(dbCol => {
        const select = document.createElement("select");
        select.name = dbCol;

        // Option vide
        const emptyOption = document.createElement("option");
        emptyOption.value = "";
        emptyOption.textContent = "-- Aucun --";
        select.appendChild(emptyOption);

        fileColumns.forEach(fileCol => {
            const option = document.createElement("option");
            option.value = fileCol;
            option.textContent = fileCol;
            select.appendChild(option);
        });

        mappingDiv.appendChild(document.createTextNode(dbCol + ": "));
        mappingDiv.appendChild(select);
        mappingDiv.appendChild(document.createElement("br"));
    });

    // 👉 afficher le bouton seulement maintenant
    document.getElementById("submitMapping").style.display = "inline-block";
}

// Étape 3 : envoi fichier + mapping vers /batch_geocode
document.addEventListener("DOMContentLoaded", () => {
    const uploadForm = document.getElementById("uploadForm");
    const fileInput = document.getElementById("fileInput");
    const statusDiv = document.getElementById("status");

    uploadForm.addEventListener("submit", async (e) => {
        e.preventDefault(); // ⛔ empêche le rechargement de la page

        if (fileInput.files.length === 0) {
            statusDiv.textContent = "Veuillez choisir un fichier";
            return;
        }

        const formData = new FormData();
        formData.append("file", fileInput.files[0]);

        statusDiv.textContent = "Envoi du fichier... ⏳";

        try {
            const response = await fetch("/batch_geocode", {
                method: "POST",
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Erreur serveur (${response.status})`);
            }

            // La réponse est un fichier ZIP
            const blob = await response.blob();
            const url = window.URL.createObjectURL(blob);

            // Création d’un lien invisible pour forcer le téléchargement
            const a = document.createElement("a");
            a.href = url;

            // Nom de fichier : resultats_bhigis_TIMESTAMP.zip
            const timestamp = new Date().toISOString().replace(/[-:T]/g, "").split(".")[0];
            a.download = `resultats_bhigis_${timestamp}.zip`;

            document.body.appendChild(a);
            a.click();
            a.remove();

            window.URL.revokeObjectURL(url);
            statusDiv.textContent = "Téléchargement terminé ✅";
        } catch (error) {
            console.error(error);
            statusDiv.textContent = "Erreur lors du traitement ❌";
        }
    });
});