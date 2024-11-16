class CategoryAPI {
    constructor() {
        this.BASE_URL = "https://finbro.yazeedmo.com/api/admin/categories";
    }

    async getCategories() {
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
                throw new Error("Failed to fetch categories");
            }
        } catch (error) {
            console.error("Error fetching categories:", error);
            throw error;
        }
    }
}

export default CategoryAPI;
