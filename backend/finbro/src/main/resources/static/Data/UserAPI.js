class UserAPI {
  constructor() {
    this.BASE_URL = "http://localhost:8081/api/admin/users";
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
}

export default UserAPI;
