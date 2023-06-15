import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class ShowAnimatedToastMessage{

  static showSaveToastMessage(BuildContext context) {
    MotionToast(
      icon: Icons.check_circle,
      primaryColor: Color(0xffF4AA39),
      title: Text("Save"),
      description: Text("Saved the recipe successfully"),
      animationType:  AnimationType.fromTop,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,

    ).show(context);
  }

  static showDeleteToastMessage(BuildContext context) {
    MotionToast(
      icon: Icons.close,
      primaryColor: Colors.red,
      title: Text("Delete"),
      description: Text("The recipe removed from the saved list!"),
      animationType:  AnimationType.fromTop,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,

    ).show(context);
  }
}