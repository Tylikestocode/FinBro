import RegularPaymentAPI from "../Data/RegularPaymentAPI.js";

const regularPaymentAPI = new RegularPaymentAPI();

class RegularPaymentService {
    async getRegularPayments() {
        try {
            const result = await regularPaymentAPI.getRegularPayments();
            return result.data;
        }
        catch (error) {
            console.error("Error in RegularPaymentService = getRegularPayments:", error);
            throw error;
        }
    }
}

export default RegularPaymentService;