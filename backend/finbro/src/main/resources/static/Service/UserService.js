import UserAPI from "../Data/UserAPI.js";

const userAPI = new UserAPI();

class UserService {

  async getUsers() {
    try {
      const result = await userAPI.getUsers();
      return result.data;
    } catch (error) {
      console.error("Error in UserService - getUsers:", error);
      throw error;
    }
  }

  async getTotalOnlineUsers() {

    try {
      const result = await userAPI.getTotalOnlineUsers();
      return result.data.data;
    }
    catch (error) {
      console.error("Error in UserService - getTotalOnlineUsers:", error);
      throw error;
    }

  }

  async getTotalUserCount() {

    try {
      const result = await userAPI.getTotalUserCount();
      return result.data.data;
    }
    catch (error) {
      console.error("Error in UserService - getTotalUserCount:", error);
      throw error;
    }

  }

}

// Export the class as the default export
export default UserService;
