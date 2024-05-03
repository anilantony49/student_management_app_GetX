import 'package:database_student/model/student_model.dart';
import 'package:database_student/ui/screens/widgets/student_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SearchStudentScreen extends StatelessWidget {
  final List<StudentModel> students;
  final filterStudent = <StudentModel>[].obs;
  // List<StudentModel> filterStudents = [];
  SearchStudentScreen({super.key, required this.students}) {
    filterStudent.value = students;
  }

  void filterStudents(String value) {
    filterStudent.value = students
        .where((student) =>
            student.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xC1C1C1C1),
          title: TextField(
            onChanged: (value) {
              filterStudents(value);
            },
            decoration: const InputDecoration(
                icon: Icon(
              Icons.search,
              color: Colors.black,
            )),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.cancel))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => filterStudent.isNotEmpty
                ? ListView.builder(
                    itemCount: filterStudent.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StudentListWidget(filterStudent[index]);
                    })
                : const Center(
                    child: Text('Student not found'),
                  ),
          ),
        ));
  }
}
