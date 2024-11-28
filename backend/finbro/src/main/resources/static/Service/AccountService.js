import AccountAPI from "../Data/AccountAPI.js";

const accountApi = new AccountAPI();

class AccountService {

    async getAccounts() {
        try {
            const result = await accountApi.getAccounts();
            return result.data;
        } catch (error) {
            console.error("Error in AccountService - getAccounts:", error);
            throw error;
        }
    }
}

export default AccountService;