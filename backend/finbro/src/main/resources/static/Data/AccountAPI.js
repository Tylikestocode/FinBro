class AccountAPI {
    constructor() {
        this.BASE_URL = "https://finbro.yazeedmo.com/api/admin/accounts";
    }

    async getAccounts() {
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
            } else {
                throw new Error("Failed to fetch accounts");
            }
        } catch (error) {
            console.error("Error fetching accounts:", error);
            throw error;
        }
    }
}

export default AccountAPI;