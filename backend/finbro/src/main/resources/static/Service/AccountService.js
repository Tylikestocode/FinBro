import AccountAPI from "../Data/AccountAPI.js";

const accountApi = new AccountAPI();

class AccountService {
    constructor() {
        this.accountData = new AccountAPI();
    }

    async getAccounts() {
        try {
            const result = await this.accountData.getAccounts();
            return result.data;
        } catch (error) {
            console.error("Error in AccountService - getAccounts:", error);
            throw error;
        }
    }
}

export default AccountService;