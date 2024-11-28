import TransactionAPI from "../Data/TransactionAPI.js";

const transactionAPI = new TransactionAPI();

class TransactionService {

    async getTransactions() {

        try {
            const result = await transactionAPI.getTransactions();
            console.log(result.data);
            return result.data;
        }
        catch (error) {
            console.error("Error in TransactionService - getTransactions", error);
            throw error;
        }
    }

}

export default TransactionService;