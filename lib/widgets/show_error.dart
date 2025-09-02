import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/screens/weather_screen.dart';

import '../constants.dart';

void showError({BuildContext? context, required String error}){
  final _context = context ?? WeatherScreen.globalKey.currentContext;
  if(_context != null){
    //showDialog(context: _context, builder: (_) => ErrorDialog(error));
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      titleText: const Text(
        'Ошибка',
        style: tsCity,
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
    ).show(_context);
  }
}