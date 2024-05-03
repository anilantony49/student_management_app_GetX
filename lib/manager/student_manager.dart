import 'dart:io';
import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentManager extends GetxController {
  static final StudentManager _instance = StudentManager._internal();

  factory StudentManager() {
    return _instance;
  }

  StudentManager._internal() {
    getStudents();
  }
  RxBool isGridView = false.obs;
  // List<StudentModel> allStudents = [].obs;
  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  File? image;


  RxList<StudentModel> allStudents = <StudentModel>[].obs;

  @override
  void onInit() {
    refresh();
    super.onInit();
  }

  @override
  Future<void> refresh() async {
    final data = await DbHelper.dbHelper.getAllStudents();
    allStudents.assignAll(data);
  }

  Future<void> getStudents() async {
    final data = await DbHelper.dbHelper.getAllStudents();
    allStudents.assignAll(data);
  }

  void insertNewStudent() {
    StudentModel studentModel = StudentModel(
        name: nameController.text,
        image: image,
        age: int.parse(ageController.text),
        address: addressController.text,
        email: emailController.text,
        phoneNumber: int.parse(phoneNumberController.text));

    DbHelper.dbHelper.insetNewStudent(studentModel);

    refresh();
    // getStudents();
  }

  Future<void> updateStudent(StudentModel studentModel) async {
    await DbHelper.dbHelper.updateStudent(studentModel);
    refresh();
    // getStudents();
  }

  void deleteStudents(StudentModel studentModel) {
    DbHelper.dbHelper.deleteStudent(studentModel);
    refresh();
    // getStudents();
  }
}
