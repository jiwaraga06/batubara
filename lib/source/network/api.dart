String baseUrl = "https://satu.sipatex.co.id:2087";
const token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1hIjoiYWRtaW5pc3RyYXRvciIsImVtYWlsIjoiZmFqYXIudHdAc2lwYXRleC5jby5pZCJ9LCJpYXQiOjE1OTIyMzUzMTZ9.8mBjIK6vAKVoPKGrhgk_E_M9x4IJwDWEvDW_3S46jU0";

class MyApi {
  static batubara() {
    return "$baseUrl/api/v2/batu-bara";
  }

  static insert() {
    return "$baseUrl/api/v2/batu-bara/insert";
  }
  static history(username) {
    return "$baseUrl/api/v2/batu-bara/get?username=$username";
  }

  static login(username, password, deviceid) {
    return "$baseUrl/api/v2/batu-bara/login?username=$username&password=$password&uuid=$deviceid";
  }

  static logout(username) {
    return "$baseUrl/api/v2/batu-bara/logout?username=$username";
  }

  static changePassword(username, password, newPassword) {
    return "$baseUrl/api/v2/batu-bara/change_password?username=$username&password=$password&new_password=$newPassword";
  }
}
