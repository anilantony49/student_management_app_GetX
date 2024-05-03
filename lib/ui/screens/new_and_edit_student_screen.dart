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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight2,
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
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
                      return 'please fill this field';
                    } else {
                      return null;
                    }
                  },
                ),
                kHeight1,
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
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
                      return 'please fill this field';
                    } else {
                      return null;
                    }
                  },
                ),
                kHeight1,
                Row(
                  children: [
                    PopupMenuButton(
                        color: kColor,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  onTap: () =>
                                      pickImage(context, ImageSource.camera),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.camera_alt_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Take a Picture')
                                    ],
                                  )),
                              PopupMenuItem(
                                  onTap: () =>
                                      pickImage(context, ImageSource.gallery),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.image_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Seletct a Picture',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ))
                            ]),
                    const Text(
                      'ADD A PICTURE',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Obx(() {
                  return Visibility(
                    visible: image.value != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            image.value = null;
                          },
                          child: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                        ),
                        if (image.value != null)
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: FileImage(image.value!),
                          ),
                      ],
                    ),
                  );
                }),
                kHeight1,
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 100,
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      expands: true,
                      maxLines: null,
                      controller: studentManager.addressController,
                      // initialValue: studentModel?.address ?? '',
                      decoration: InputDecoration(
                          label: const Text(
                            'Address',
                            style: TextStyle(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill this field';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                kHeight1,
                SizedBox(
                  // height: 100,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
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
                        return 'please fill this field';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                kHeight1,
                SizedBox(
                  // height: 100,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
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
                  ),
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
    );
  }
}
