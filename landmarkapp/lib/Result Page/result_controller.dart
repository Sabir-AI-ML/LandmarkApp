// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as d;

class ResultController extends GetxController {
  uploadFile({required bool isCamera}) async {
    var uploadedFile = false.obs;
    XFile? pickedFile;
    late Rx<d.MultipartFile> file;
    if (isCamera) {
      pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;

      final File image = (File(pickedFile!.path));
      file = (await d.MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last))
          .obs;
      uploadedFile.value = true;
    } else {
      pickedFile = await ImagePicker().pickMedia();
      if (pickedFile == null) return;

      final File image = (File(pickedFile!.path));
      file = (await d.MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last))
          .obs;
      uploadedFile.value = true;
    }
  }
}
