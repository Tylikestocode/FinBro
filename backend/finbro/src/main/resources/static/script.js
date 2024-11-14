import UserService from "./Service/UserService.js";
import AccountService from "./Service/AccountService.js";
import CategoryService from "./Service/CategoryService.js";

const userService = new UserService();
const accountService = new AccountService();
const categoryService = new CategoryService();

document.addEventListener('DOMContentLoaded', () => {

  console.log("Hellllooooooo");

  linkTabsAndMainSections();

  fetchAndPopulateUsers();
  fetchAndPopulateAccounts();
  fetchAndPopulateCategories();

  showGraphs();

  setInterval(fetchAndPopulateUsers, 60000);
  setInterval(fetchAndPopulateAccounts, 60000);
  setInterval(fetchAndPopulateCategories, 60000);

})

function linkTabsAndMainSections() {

  // Select all tabs and content sections
  const tabs = document.querySelectorAll('.tab');
  const contentSections = document.querySelectorAll('.content-section');

  console.log(tabs.length);
  console.log(contentSections.length);

  // Function to hide all sections and remove active class from tabs
  function resetActiveStates() {
    contentSections.forEach(section => section.classList.remove('active'));
    tabs.forEach(tab => tab.classList.remove('active'));
  }

  // Add event listener to each tab
  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      // Reset all active classesr
      resetActiveStates();

      // Activate the clicked tab
      tab.classList.add('active');

      // Show the corresponding content section
      const contentId = tab.getAttribute('data-content');
      document.getElementById(contentId).classList.add('active');
    })
  })


}

async function fetchAndPopulateUsers() {

  try {
    const allUsers = await userService.getUsers();
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

async function fetchAndPopulateAccounts() {

  try {
    const allAccounts = await accountService.getAccounts();
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

async function fetchAndPopulateCategories() {

  try {
    const allCategories = await categoryService.getCategories();
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

function showGraphs() {
  const charts = document.querySelectorAll(".chart");

  charts.forEach(function (chart) {
    var ctx = chart.getContext("2d");
    var myChart = new Chart(ctx, {
      type: "bar",
      data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [
          {
            label: "# of Votes",
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
              "rgba(255, 99, 132, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(255, 206, 86, 0.2)",
              "rgba(75, 192, 192, 0.2)",
              "rgba(153, 102, 255, 0.2)",
              "rgba(255, 159, 64, 0.2)",
            ],
            borderColor: [
              "rgba(255, 99, 132, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 206, 86, 1)",
              "rgba(75, 192, 192, 1)",
              "rgba(153, 102, 255, 1)",
              "rgba(255, 159, 64, 1)",
            ],
            borderWidth: 1,
          },
        ],
      },
      options: {
        scales: {
          y: {
            beginAtZero: true,
          },
        },
      },
    });
  });

}
