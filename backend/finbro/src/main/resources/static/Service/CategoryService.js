import CategoryAPI from '../Data/CategoryAPI.js';

const categoryApi = new CategoryAPI();

class CategoryService {
    async getCategories() {
        try {
            const result = await categoryApi.getCategories();
            return result.data;
        } catch (error) {
            console.error("Error in CategoryService - getCategories:", error);
            throw error;
        }
    }
}

// Export the class as the default export
export default CategoryService;
