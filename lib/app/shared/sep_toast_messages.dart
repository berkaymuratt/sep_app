import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

void displaySuccessMessage(BuildContext context, {required String content}) {
  MotionToast.success(
    title: const Text(
      'İşlem Başarılı',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(
      content,
      style: const TextStyle(fontSize: 12),
    ),
    layoutOrientation: ToastOrientation.ltr,
    animationType: AnimationType.fromLeft,
    dismissable: true,
    animationDuration: const Duration(seconds: 2),
  ).show(context);
}

void displayErrorMessage(BuildContext context, {required content}) {
  MotionToast.error(
    title: const Text(
      'Hata Oluştu',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(
      content,
      style: const TextStyle(fontSize: 12),
    ),
    layoutOrientation: ToastOrientation.ltr,
    animationType: AnimationType.fromLeft,
    dismissable: true,
    animationDuration: const Duration(seconds: 1),
  ).show(context);
}