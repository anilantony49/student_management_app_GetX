import 'package:database_student/model/student_model.dart';

import 'package:database_student/ui/screens/show_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class StudentListWidget extends StatelessWidget {
  final StudentModel studentModel;
  const StudentListWidget(
    this.studentModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Get.to(()=>ShowStudentScreen(studentModel: studentModel));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              tileColor:kColor,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: CircleAvatar(
                  radius: 35,

                  // backgroundImage: studentManager.image==null||studentManager.image!.isEmpty ?  AssetImage('assets/images/blank profile.jpg'):FileImage(studentManager.image!),
                  backgroundImage: FileImage(studentModel.image!),
                ),
              ),
              title: Text(
                studentModel.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
