import WebSocketAPI from "./Data/WebSocketAPI.js";
import UserService from "./Service/UserService.js";
import AccountService from "./Service/AccountService.js";
import CategoryService from "./Service/CategoryService.js";
import RegularPaymentService from "./Service/RegularPaymentService.js";
import PdfService from "./Service/PdfService.js";
import ApkService from "./Service/ApkService.js";
import Tables from "./ui/Tables.js";

const userService = new UserService();
const accountService = new AccountService();
const categoryService = new CategoryService();
const regularPaymentService = new RegularPaymentService();
const pdfService = new PdfService();
const apkService = new ApkService();

const tables = new Tables();

let stompClient = null;

window.downloadFile = function (fileType) {
  pdfService.downloadPdf();
}

window.downloadApk = function () {
  apkService.downloadApk();
}


document.addEventListener('DOMContentLoaded', () => {

  linkTabsAndMainSections();

  updateOnlineUserCount();
  updateTotalUserCount();

  initializeWebSocketConnection();

  tables.fetchAndPopulateUsers();
  tables.fetchAndPopulateCategories();
  tables.fetchAndPopulateAccounts();
  tables.fetchAndPopulateRegularPayments();
  tables.fetchAndPopulateTransactions();

  showGraphs();

})

function linkTabsAndMainSections() {

  // Select all tabs and content sections
  const tabs = document.querySelectorAll('.tab');
  const contentSections = document.querySelectorAll('.content-section');

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

async function updateOnlineUserCount() {

  let count = await userService.getTotalOnlineUsers();

  // Update the online user count in the card
  const userCountElement = document.getElementById('online-user-count');
  userCountElement.textContent = count;

  const cardElement = document.getElementById('online-users-card');
  if (count === 0) {
    cardElement.classList.replace('text-bg-success', 'text-bg-secondary');
    cardElement.querySelector('.card-text').textContent = 'No active users at the moment';
  } else {
    cardElement.classList.replace('text-bg-secondary', 'text-bg-success');
    cardElement.querySelector('.card-text').textContent = 'Currently active users';
  }
}

async function updateTotalUserCount() {

  let count = await userService.getTotalUserCount();

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
    cardElement.querySelector('.card-text').textContent = 'Registered users';
  }

}

function initializeWebSocketConnection() {

  stompClient = new WebSocketAPI();

  // Register handlers for different event types
  stompClient.registerEventHandler('ONLINE_USER_COUNT', updateOnlineUserCount);
  stompClient.registerEventHandler('TOTAL_USER_COUNT', updateTotalUserCount);
  stompClient.registerEventHandler('USERS_UPDATED', () => {
    tables.fetchAndPopulateUsers();
    updateOnlineUserCount();
    updateTotalUserCount();
  });

  stompClient.registerEventHandler('CATEGORIES_UPDATED', tables.fetchAndPopulateCategories.bind(tables));
  stompClient.registerEventHandler('ACCOUNTS_UPDATED', tables.fetchAndPopulateAccounts.bind(tables));
  stompClient.registerEventHandler('REGULAR_PAYMENTS_UPDATED', tables.fetchAndPopulateRegularPayments.apply(tables));
  stompClient.registerEventHandler('TRANSACTIONS_UPDATED', tables.fetchAndPopulateTransactions.bind(tables));

  // Initialize the WebSocket connection
  stompClient.initialize();

}

function downloadPdf() {
  fetch('http://localhost:8081/api/admin/download-pdf')
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.blob();
    })
    .then(blob => {
      console.log("In the blob");
      // Create a link element to download the file
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'stats.pdf'; // Filename for the downloaded file
      document.body.appendChild(a);
      a.click();
      a.remove(); // Remove the link after downloading
      window.URL.revokeObjectURL(url);
    })
    .catch(error => {
      console.error('There was an error downloading the file:', error);
    });
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