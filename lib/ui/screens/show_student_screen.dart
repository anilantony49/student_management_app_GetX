
import 'package:database_student/model/student_model.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:database_student/ui/screens/new_and_edit_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/constants.dart';

class ShowStudentScreen extends StatelessWidget {
  final StudentModel studentModel;
  const ShowStudentScreen({super.key, required this.studentModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC1C1C1C1),
        actions: [
          InkWell(
            onTap: () {
              StudentManager studentManager = StudentManager();
              studentManager.nameController.text = studentModel.name;
              studentManager.ageController.text = studentModel.age.toString();
              studentManager.addressController.text = studentModel.address;
              studentManager.phoneNumberController.text =
                  studentModel.phoneNumber.toString();
              studentManager.emailController.text = studentModel.email;
              studentManager.image = studentModel.image;

              Get.to(() => NewAndEditStudentScreen(
                    studentModel: studentModel,
                    isEditing: true,
                  ));
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      title: const Text('Delete'),
                      content: const Text('Are you sure want to delete?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              StudentManager().deleteStudents(studentModel);
                              Get.to(() => const HomeScreen());
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Delete succesfully'),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                              ));
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: kColor),
                            )),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(color: kColor),
                            ))
                      ],
                    );
                  });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              kHeight2,
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: kColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 170,
                child: studentModel.image == null ||
                        studentModel.image!.path.isEmpty
                    ? const Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/blank profile.jpg'),
                        ),
                      )
                    : Image.file(studentModel.image!),
              ),
              kHeight2,
              Center(
                child: Text(
                  studentModel.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              kHeight1,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Age :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      studentModel.age.toString(),
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              kHeight2,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    kHeight1,
                    Text(
                      studentModel.address,
                      style: const TextStyle(fontSize: 26),
                    )
                  ],
                ),
              ),
              kHeight2,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'phone number',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    kHeight1,
                    Text(
                      studentModel.phoneNumber.toString(),
                      style: const TextStyle(fontSize: 26),
                    )
                  ],
                ),
              ),
              kHeight2,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'email',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    kHeight1,
                    Text(
                      studentModel.email,
                      style: const TextStyle(fontSize: 26),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
