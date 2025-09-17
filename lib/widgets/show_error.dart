import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

void showErrorFlushbar({required BuildContext context, required String error}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    titleText: const Text(
      'Ошибка',
      style: tsDefault,
    ),
    messageText: Text(
      error,
      style: tsMini,
    ),
    duration: const Duration(seconds: 5),
    isDismissible: false,
    borderRadius: BorderRadius.circular(15),
    backgroundGradient: bdGradient,
    borderWidth: 2,
    borderColor: Colors.white,
    margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
  ).show(context);
}
