import CONFIG from "../util/config.js";

class PdfService {

    constructor() {
        this.BASE_URL = `${CONFIG.BASE_URL}/admin/download-pdf`;
    }

    async downloadPdf() {

        fetch(this.BASE_URL)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.blob();
            })
            .then(blob => {
                console.log("In the blob");
                // Create a link element to download the file
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'stats.pdf'; // Filename for the downloaded file
                document.body.appendChild(a);
                a.click();
                a.remove(); // Remove the link after downloading
                window.URL.revokeObjectURL(url);
            })
            .catch(error => {
                console.error('There was an error downloading the file:', error);
            });

    }

}

export default PdfService;