import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:database_student/ui/screens/new_and_edit_student_screen.dart';
import 'package:database_student/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitApp();
  }
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentManager());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF596157),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      title: 'Student database app',
      home: const SplashScreen(),
      getPages: [
        GetPage(
          name: '/new_student_screen',
          page: () =>   NewAndEditStudentScreen(isEditing: false,),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/main_screen',
          page: () =>  const HomeScreen(),
          transition: Transition.fade,
        )
      ],
      
    );
  }
}
