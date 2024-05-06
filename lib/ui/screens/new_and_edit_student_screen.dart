import 'dart:io';

import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/model/student_model.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:database_student/ui/screens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewAndEditStudentScreen extends StatelessWidget {
  final StudentModel? studentModel;
  final bool isEditing;
  NewAndEditStudentScreen(
      {super.key, this.studentModel, required this.isEditing});

  final formKey = GlobalKey<FormState>();
  final studentManager = Get.find<StudentManager>();
  final Rx<File?> image = Rx<File?>(null);

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    image.value = File(pickedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC1C1C1C1),
        title: Text(isEditing ? 'Edit Student' : 'Add New Student'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kHeight2,
                  GestureDetector(
                    onTap: () {
                      pickImage(context, ImageSource.camera);
                    },
                    child: CircleAvatar(
                      backgroundColor: const Color(0xC1C1C1C1),
                      radius: 70,
                      backgroundImage: studentManager.image != null
                          ? FileImage(studentManager.image!)
                          : null,
                      child: studentManager.image == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ),
                  kHeight2,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    controller: studentManager.nameController,
                    decoration: InputDecoration(
                        label: const Text(
                          'Name',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight1,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                    controller: studentManager.ageController,
                    decoration: InputDecoration(
                        label: const Text(
                          'Age',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Age is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight1,
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: 100,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        maxLines: 3,
                        controller: studentManager.addressController,
                        decoration: InputDecoration(
                            label: const Text(
                              'Address',
                              style: TextStyle(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  kHeight1,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                    controller: studentManager.phoneNumberController,
                    // initialValue: studentModel?.phoneNumber.toString() ?? '',
                    decoration: InputDecoration(
                        label: const Text(
                          'Phone number',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight1,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    controller: studentManager.emailController,
                    // initialValue: studentModel?.email ?? '',
                    decoration: InputDecoration(
                        label: const Text(
                          'email',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'email is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight1,
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color(0xC1C1C1C1),
                      )),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          if (isEditing) {
                            studentModel!.name =
                                studentManager.nameController.text;
                            studentModel!.age =
                                int.parse(studentManager.ageController.text);
                            studentModel!.image = studentManager.image;
                            studentModel!.address =
                                studentManager.addressController.text;
                            studentModel!.phoneNumber = int.parse(
                                studentManager.phoneNumberController.text);
                            studentModel!.email =
                                studentManager.emailController.text;

                            studentManager.updateStudent(studentModel!);
                            studentManager.nameController.clear();
                            studentManager.ageController.clear();
                            studentManager.addressController.clear();
                            studentManager.emailController.clear();
                            studentManager.phoneNumberController.clear();
                            image.value = null;
                            Get.to(() => const HomeScreen());
                          } else {
                            studentManager.image = image.value;
                            studentManager.insertNewStudent();
                            studentManager.nameController.clear();
                            studentManager.ageController.clear();
                            studentManager.addressController.clear();
                            studentManager.phoneNumberController.clear();
                            studentManager.emailController.clear();
                            image.value = null;

                            studentManager.nameController.clear();
                            studentManager.ageController.clear();
                            studentManager.addressController.clear();
                            studentManager.emailController.clear();
                            studentManager.phoneNumberController.clear();
                            image.value = null;
                            Get.back();
                          }

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(isEditing
                                ? 'Edit Successfully'
                                : 'Save Successfully'),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(10),
                          ));
                        }
                      },
                      child: Center(
                        child: Text(
                          isEditing ? 'Save Changes' : 'Save',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
