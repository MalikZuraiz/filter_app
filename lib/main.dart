import 'package:filterapp/config/app_db.dart';
import 'package:filterapp/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  await AppDatabase().database;
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filter Me',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.light,
    );
}
}