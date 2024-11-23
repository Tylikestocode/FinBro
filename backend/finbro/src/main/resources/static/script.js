import UserService from "./Service/UserService.js";
import AccountService from "./Service/AccountService.js";
import CategoryService from "./Service/CategoryService.js";
import RegularPaymentService from "./Service/RegularPaymentService.js";

const userService = new UserService();
const accountService = new AccountService();
const categoryService = new CategoryService();
const regularPaymentService = new RegularPaymentService();

let stompClient = null;

document.addEventListener('DOMContentLoaded', () => {

  linkTabsAndMainSections();

  fetchTotalOnlineUsers();
  fetchTotalUserCount();

  intializeWebSocketConnection();

  fetchAndPopulateUsers();
  fetchAndPopulateCategories();
  fetchAndPopulateAccounts();
  fetchAndPopulateRegularPayments();

  showGraphs();

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

async function fetchTotalOnlineUsers() {
  try {
    const response = await fetch('https://finbro.yazeedmo.com/api/admin/online-users/count');
    if (!response.ok) {
      throw new Error('Failed to fetch online user count');
    }
    const result = await response.json();

    if (result.success && result.data.eventType === 'ONLINE_USER_COUNT') {
      const count = result.data.data;
      updateOnlineUserCount(count);
    } else {
      console.error('Unexpected response structure:', result);
    }
  } catch (error) {
    console.error('Error fetching initial user count:', error);
  }
}

async function fetchTotalUserCount() {

  try {
    const response = await fetch('https://finbro.yazeedmo.com/api/admin/total-users/count');
    if (!response.ok) {
      throw new Error('Failed to fetch total user count');
    }
    const result = await response.json();

    if (result.success && result.data.eventType === 'TOTAL_USER_COUNT') {
      const count = result.data.data;
      console.log("Total Users: " + count);
      updateTotalUserCount(count);
    } else {
      console.error('Unexpected response structure:', result);
    }
  } catch (error) {
    console.error('Error fetching total user count:', error);
  }

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

async function fetchAndPopulateRegularPayments() {

  try {
    const allRegularPayments = await regularPaymentService.getRegularPayments();
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

function intializeWebSocketConnection() {

  // Create WebSocket connection
  const socket = new SockJS('https://finbro.yazeedmo.com/ws');
  // Wrap WebSocket connection with Stomp
  stompClient = Stomp.over(socket);

  // Establish connection
  stompClient.connect({}, onConnected, onError);

  // Callback for successful connection
  function onConnected(frame) {
    console.log('Connected: ' + frame);

    stompClient.subscribe('/topic/adminUpdates', function (message) {
      const event = JSON.parse(message.body);
      const eventType = event.eventType;
      switch (eventType) {
        case 'ONLINE_USER_COUNT':
          updateOnlineUserCount(event.data);
          break;
        case 'TOTAL_USER_COUNT':
          updateTotalUserCount(event.data);
          break;
        case 'USERS_UPDATED':
          fetchAndPopulateUsers();
          fetchTotalUserCount();
          break;
        case 'CATEGORIES_UPDATED':
          fetchAndPopulateCategories();
          break;
        case 'ACCOUNTS_UPDATED':
          fetchAndPopulateAccounts();
          break;
        case 'REGULAR_PAYMENTS_UPDATED':
          fetchAndPopulateRegularPayments();
          break;
        default:
          console.log('Unknown event type: ', eventType);
      }
    });
  }

  // Callback for connection errors
  function onError(error) {
    console.error('Connection error: ' + error);
  }

}

function updateOnlineUserCount(count) {
  // Update the online user count in the card
  const userCountElement = document.getElementById('online-user-count');
  userCountElement.textContent = count;

  const cardElement = document.getElementById('online-users-card');
  if (count === 0) {
    console.log("No current users");
    cardElement.classList.replace('text-bg-success', 'text-bg-secondary');
    cardElement.querySelector('.card-text').textContent = 'No active users at the moment';
  } else {
    cardElement.classList.replace('text-bg-secondary', 'text-bg-success');
    cardElement.querySelector('.card-text').textContent = 'Currently active users';
  }
}

function updateTotalUserCount(count) {

  // Update the total user count in the card
  const userCountElement = document.getElementById('total-user-count');
  userCountElement.textContent = count;

  // Optionally, dynamically change the card's appearance based on count
  const cardElement = document.getElementById('total-users-card');
  if (count === 0) {
    cardElement.classList.replace('text-bg-info', 'text-bg-secondary');
    cardElement.querySelector('.card-text').textContent = 'No registered users yet';
  } else {
    cardElement.classList.replace('text-bg-secondary', 'text-bg-info');
    cardElement.querySelector('.card-text').textContent = 'Registered users in the system';
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