class AppConstants {
  static const String appName = 'Task Manager';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String tasksCollection = 'tasks';

  // Task status
  static const String pending = 'Pending';
  static const String completed = 'Completed';

  //  Home Screen
  static const String myTask = 'My Tasks';
  static const String logout = 'Logout';
  static const String cancel = 'Cancel';
  static const String logoutPermissionText = 'Are you sure you want to logout?';
  static const String noDataMessageText = 'No tasks yet. Add your first task!';

  // Task-Title Screen
  static const String deleteTask = 'Delete Task';
  static const String deletePermissionText =
      'Are you sure you want to delete this task?';
  static const String delete = 'Delete';

  /// Edit-Task Screen
  static const String editTask = 'Edit Task';
  static const String title = 'Title';
  static const String description = 'Description';
  static const String status = 'Status';
  static const String errorMessage = 'Error';
  static const String errorMessageText = 'Title cannot be empty';
  static const String updateTask = 'Update Task';

  /// Add-Task Screen
  static const String addTask = 'Add Task';

  /// Signup Screen
  static const String signUp = 'Sign Up';
  static const String alreadyHaveAnAccount = 'Already have an account? Login';

  /// Login Screen
  static const String login = 'Login';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String dontHaveAnAccounttext = 'Don\'t have an account? Sign up';

  /// Connectivity
  static const String noInternetTitle = 'No Internet';
  static const String noInternetMessage = 'Please check your internet connection.';
}
