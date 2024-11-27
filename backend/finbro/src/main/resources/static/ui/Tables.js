import UserService from "../Service/UserService.js";
import AccountService from "../Service/AccountService.js";
import CategoryService from "../Service/CategoryService.js";
import RegularPaymentService from "../Service/RegularPaymentService.js";

class Tables {

    constructor() {
        this.userService = new UserService();
        this.accountService = new AccountService();
        this.categoryService = new CategoryService();
        this.regularPaymentService = new RegularPaymentService();
    }

    async fetchAndPopulateUsers() {

        try {
            const allUsers = await this.userService.getUsers();
            console.log(allUsers);

            let tableBody = $('#user-table tbody');
            tableBody.empty();

            allUsers.forEach(user => {
                let row = `<tr>
              <td>${user.id}</td>
              <td>${user.name}</td>
              <td>${user.surname}</td>
              <td>${user.age}</td>
              <td>${user.username}</td>
              <td>${user.email}</td>
            </tr>`;

                tableBody.append(row);
            });

            $('#user-table').DataTable();

        }
        catch (error) {
            console.log(error);
        }
    }

    async fetchAndPopulateCategories() {

        try {
            const allCategories = await this.categoryService.getCategories();
            console.log(allCategories);

            let tableBody = $('#category-table tbody');
            tableBody.empty();

            allCategories.forEach(category => {
                let row =
                    `
            <tr>
              <td>${category.id}</td>
              <td>${category.name}</td>
              <td>${category.type}</td>
              <td>${category.description}</td>
              <td>${category.userId}</td>
              <td>${category.userDefined}</td>
            </tr>
            `;

                tableBody.append(row);

            })
        }
        catch (error) {
            console.log(error);
        }

    }

    async fetchAndPopulateAccounts() {

        try {
            const allAccounts = await this.accountService.getAccounts();
            console.log(allAccounts);

            let tableBody = $('#account-table tbody');
            tableBody.empty();

            allAccounts.forEach(account => {
                let row =
                    `<tr>
              <td>${account.id}</td>
              <td>${account.name}</td>
              <td>${account.allowNegativeBalance}</td>
              <td>${account.minimumBalance}</td>
              <td>${account.balance}</td>
              <td>${account.dateCreated}</td>
              <td>${account.notes}</td>
              <td>${account.userId}</td>
              <td>${account.categoryId}</td>
            </tr>`;

                tableBody.append(row);

            });
            $('#account-table').DataTable();
        }
        catch (error) {
            console.log(error);
        }

    }

    async fetchAndPopulateRegularPayments() {

        try {
            const allRegularPayments = await this.regularPaymentService.getRegularPayments();
            console.log(allRegularPayments);
            let tableBody = $('#regular-payment-table tbody');
            tableBody.empty();

            allRegularPayments.forEach(regularPayment => {
                let row =
                    `
            <tr>
              <td>${regularPayment.id}</td>
              <td>${regularPayment.name}</td>
              <td>${regularPayment.amount}</td>
              <td>${regularPayment.frequency}</td>
              <td>${regularPayment.nextDate}</td>
              <td>${regularPayment.endDate}</td>
              <td>${regularPayment.notes}</td>
              <td>${regularPayment.userId}</td>
              <td>${regularPayment.accountId}</td>
              <td>${regularPayment.categoryId}</td>
            </tr>      
            `;

                tableBody.append(row);

            });
            $('#regular-payment-table').DataTable();
        }
        catch (error) {
            console.log(error);
        }

    }


}

export default Tables;