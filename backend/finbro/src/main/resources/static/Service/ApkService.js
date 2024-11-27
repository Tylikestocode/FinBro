import CONFIG from "../util/config.js";

class ApkService {

    constructor() {
        this.BASE_URL = `${CONFIG.BASE_URL}/admin/download-apk`;
    }


    async downloadApk() {
        const apkDownloadUrl = this.BASE_URL;
        const downloadBtn = document.getElementById("apk-download-btn");
        const btnText = document.getElementById("apk-btn-text");
        const spinner = document.getElementById("apk-spinner");
        const progressContainer = document.getElementById("apk-progress");
        const progressBar = document.getElementById("apk-progress-bar");

        try {
            // Show loading spinner and progress bar
            spinner.classList.remove("d-none");
            progressContainer.classList.remove("d-none");
            downloadBtn.disabled = true;

            // Make the fetch request to download the APK
            const response = await fetch(apkDownloadUrl);

            // Check if the response was successful
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            // Get the Content-Length header
            const contentLength = response.headers.get("Content-Length");

            // If the Content-Length is not available, show an alert or handle it as needed
            if (!contentLength) {
                throw new Error("Content-Length header is missing");
            }

            // Convert the contentLength to a number
            const total = parseInt(contentLength, 10);
            let loaded = 0;

            // Create a stream reader to read the response body in chunks
            const reader = response.body.getReader();
            const chunks = [];

            // Read the file in chunks and update the progress bar
            while (true) {
                const { done, value } = await reader.read();
                if (done) break; // Exit the loop when the download is complete

                // Push the chunk into the chunks array
                chunks.push(value);

                // Update the amount of data loaded
                loaded += value.length;

                // Calculate the percentage of the download completed
                const percentage = Math.round((loaded / total) * 100);

                // Update the progress bar width and text
                progressBar.style.width = `${percentage}%`;
                progressBar.innerText = `${percentage}%`;
            }

            // Combine the chunks into a single Blob
            const blob = new Blob(chunks);

            // Create a URL for the Blob
            const url = window.URL.createObjectURL(blob);

            // Trigger the download by creating an anchor tag and clicking it
            const a = document.createElement("a");
            a.href = url;
            a.download = "app-release.apk";  // Set the desired file name
            document.body.appendChild(a);
            a.click();
            a.remove();

            // Clean up the Blob URL after use
            window.URL.revokeObjectURL(url);

        } catch (error) {
            console.error('Error downloading APK:', error);
            alert("There was an error downloading the file. Please try again.");
        } finally {
            // Hide loading spinner and reset progress bar
            spinner.classList.add("d-none");
            downloadBtn.disabled = false;
            progressContainer.classList.add("d-none");
            progressBar.style.width = "0%";
            progressBar.innerText = "";
        }
    }




}

export default ApkService;