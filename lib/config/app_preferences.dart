// import 'package:bolo/config/app_const.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppPreferences {


//    // Save the current chat ID in SharedPreferences
//   static Future<void> setCurrentChatId(String chatId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(UserKey.CURRENT_CHAT_ID, chatId);
//   }

//   // Load the current chat ID from SharedPreferences
//   static Future<String?> getCurrentChatId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(UserKey.CURRENT_CHAT_ID);
//   }




//   // Load the saved theme state from SharedPreferences
//   Future<bool> getTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(UserKey.IS_DARK_MODE) ??
//         false; // Default to light mode
//   }

//   // Save the theme state in SharedPreferences
//   Future<void> setTheme(bool isDarkMode) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(UserKey.IS_DARK_MODE, isDarkMode);
//   }

//   static Future<void> setUserLoggedIn(bool isLoggedIn) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(UserSession.IS_USER_LOGGED_IN,
//         isLoggedIn); //place the value of isLoggedIn here to set the user as logged in
//   }

//   static Future<bool> isUserLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(UserSession.IS_USER_LOGGED_IN) ?? false;
//   }

//   // Save the user category selection state in SharedPreferences
//   static Future<void> setUserChoosedCategory(bool isChoosed) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(UserKey.IS_USER_CHOOSED_CATEGORY, isChoosed);
//   }

//   // Load the user category selection state from SharedPreferences
//   static Future<bool> isUserChoosedCategory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(UserKey.IS_USER_CHOOSED_CATEGORY) ?? false;
//   }

 
// }
