class AppUrl {
  static String baseUrl = 'https://task-manager-api.ostad.live/api/v1';
  static String signUpUrl = "$baseUrl/Registration";
  static String loginUrl = "$baseUrl/Login";
  static String taskStatusCountUrl = "$baseUrl/taskStatusCount";
  static String listTaskByStatusUrl(String status) =>
      "$baseUrl/listTaskByStatus/$status";
  static String createTaskUrl = "$baseUrl/createTask";
}
