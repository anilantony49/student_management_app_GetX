import 'package:database_student/model/student_model.dart';
import 'package:database_student/ui/screens/show_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class StudentGridWidget extends StatelessWidget {
  final StudentModel studentModel;
  const StudentGridWidget(
    this.studentModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ShowStudentScreen(studentModel: studentModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          color: kColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(studentModel.image!),
              ),
              Text(
                studentModel.name,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
