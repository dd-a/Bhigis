document.getElementById("upload-form").addEventListener("submit", async function(e) {
    e.preventDefault();
    const fileInput = document.getElementById("file-input");
    if (!fileInput.files.length) return;

    const formData = new FormData();
    formData.append("file", fileInput.files[0]);

    document.getElementById("status").innerText = "Traitement en cours...";

    try {
        const response = await fetch("/batch_geocode", {
            method: "POST",
            body: formData
        });

        if (!response.ok) {
            document.getElementById("status").innerText = "Erreur lors du traitement.";
            return;
        }

        const blob = await response.blob();
        const downloadUrl = URL.createObjectURL(blob);
        const link = document.getElementById("download-link");
        link.href = downloadUrl;
        link.download = "bhigis_resultats.zip";

        document.getElementById("status").innerText = "Traitement terminé ✔";
        document.getElementById("download-section").style.display = "block";

    } catch (err) {
        document.getElementById("status").innerText = "Erreur : " + err;
    }
});

document.getElementById("fileInput").addEventListener("change", async function() {
    const file = this.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("file", file);

    const response = await fetch("/analyze_file", {
        method: "POST",
        body: formData
    });

    const data = await response.json();
    if (data.error) {
        alert(data.error);
        return;
    }

    const mappingArea = document.getElementById("mapping-area");
    mappingArea.innerHTML = ""; // reset

    data.expected.forEach(expectedCol => {
        const div = document.createElement("div");
        div.style.marginBottom = "10px";

        const label = document.createElement("label");
        label.textContent = `${expectedCol} : `;

        const select = document.createElement("select");
        select.name = `map_${expectedCol}`;

        // Option vide
        const emptyOption = document.createElement("option");
        emptyOption.value = "";
        emptyOption.textContent = "-- choisir --";
        select.appendChild(emptyOption);

        // Ajouter toutes les colonnes détectées
        data.columns.forEach(col => {
            const option = document.createElement("option");
            option.value = col;
            option.textContent = col;
            select.appendChild(option);
        });

        div.appendChild(label);
        div.appendChild(select);
        mappingArea.appendChild(div);
    });
});