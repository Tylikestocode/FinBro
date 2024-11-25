import CONFIG from "../util/config.js";

class UserAPI {
  constructor() {
    this.BASE_URL = `${CONFIG.BASE_URL}/admin/users`;
  }

  async getUsers() {
    try {
      const response = await fetch(this.BASE_URL, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });
      if (response.ok) {
        const result = await response.json();
        return result;
      } else {
        throw new Error("Failed to fetch users");
      }
    } catch (error) {
      console.error("Error fetching users:", error);
      throw error;
    }
  }



  async getTotalOnlineUsers() {
    try {
      const response = await fetch(`${CONFIG.BASE_URL}/admin/online-users/count`);
      if (!response.ok) {
        throw new Error('Failed to fetch online user count');
      }
      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error fetching initial user count:', error);
    }
  }

  async getTotalUserCount() {

    try {
      const response = await fetch(`${CONFIG.BASE_URL}/admin/total-users/count`);
      if (!response.ok) {
        throw new Error('Failed to fetch total user count');
      }
      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error fetching total user count:', error);
    }

  }
}



export default UserAPI;
