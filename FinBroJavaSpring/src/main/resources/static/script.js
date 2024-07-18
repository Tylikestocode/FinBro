//displayAllUsers();
//
//heading.textContent = "testing"
//
//async function getAllUsers() {
//
//    try {
//        const response = await fetch('api/users/allUsers');
//        if (!response.ok) {
//            throw new Error("Error fetching data");
//        }
//        const data = await response.json();
//        return data;
//    }
//    catch (error) {
//        console.error('There was a problem with the fetch operation: ', error);
//    }
//}
//
//async function displayAllUsers() {
//
//    const allUsers = await getAllUsers();
//
//    heading.textContent = allUsers;
//
//}