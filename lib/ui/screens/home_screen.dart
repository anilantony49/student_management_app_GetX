import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/search_student_screen.dart';
import 'package:database_student/ui/screens/widgets/popup_menu_button.dart';
import 'package:database_student/ui/screens/widgets/student_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/student_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final bool isGridView = false;

  @override
  Widget build(BuildContext context) {
    final StudentManager studentManager = Get.put(StudentManager());
    // studentManager.refresh();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC1C1C1C1),
        title: const Text('Students List'),
        actions: [
          InkWell(
            onTap: () => Get.to(() =>
                SearchStudentScreen(students: studentManager.allStudents)),
            child: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: studentManager.toggleView,
            icon: Obx(() => studentManager.isGridView.value
                ? const Icon(Icons.list)
                : const Icon(Icons.grid_view)),
          ),
          const MyPopupMenuButton()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xC1C1C1C1),
        onPressed: () async {
          await Get.toNamed('/new_student_screen');
          Get.offNamed('/main_screen');
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() =>
          studentManager.isGridView.value ? buildGridView() : buildListView()),
    );
  }

  Widget buildListView() {
    StudentManager studentManager = StudentManager();

    return ListView.builder(
        itemCount: studentManager.allStudents.length,
        itemBuilder: (context, index) {
          return StudentListWidget(studentManager.allStudents[index]);
        });
  }

  Widget buildGridView() {
    StudentManager studentManager = StudentManager();

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20, // Spacing between columns
          mainAxisSpacing: 20, // Spacing between rows
          childAspectRatio: 1,
        ),
        itemCount: studentManager.allStudents.length,
        itemBuilder: (context, index) {
          return StudentGridWidget(studentManager.allStudents[index]);
        });
  }
}
