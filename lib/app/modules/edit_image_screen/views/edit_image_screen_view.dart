import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_image_screen_controller.dart';

class EditImageScreenView extends GetView<EditImageScreenController> {
  const EditImageScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditImageScreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EditImageScreenView is working ${controller.mediaItem.filepath}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
