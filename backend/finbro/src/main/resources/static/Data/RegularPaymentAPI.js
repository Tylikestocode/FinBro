import CONFIG from "../util/config.js";

class RegularPaymentAPI {
    constructor() {
        this.BASE_URL = `${CONFIG.BASE_URL}/admin/regular-payments`;
    }

    async getRegularPayments() {
        try {
            const response = await fetch(this.BASE_URL, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json",
                },
            });
            if (response.ok) {
                const result = await response.json();
                return result;
            }
            else {
                throw new Error("Failed to fetch regular payments");
            }
        }
        catch (error) {
            console.error("Error fetching regular payments:", error);
            throw error;
        }
    }
}

export default RegularPaymentAPI;