import 'package:flutter/material.dart';
const TextStyle tsBigTemp = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w600,
  fontSize: 180,
  color: Colors.black,
);
const TextStyle tsDefault = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w400,
  fontSize: 30,
  color: Colors.black,
);
const TextStyle tsTitleBolt = TextStyle(
  fontSize: 45,
  fontFamily: 'Effra',
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);
const TextStyle tsLite = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w300,
  fontSize: 30,
  color: Colors.black87,
);
const TextStyle tsCity = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w300,
  fontSize: 25,
  color: Colors.white,
);
const TextStyle tsMiniLite = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w400,
  fontSize: 30,
  color: Colors.white,
  // shadows: [Shadow(
  //     offset: Offset(4.0, 4.0),
  //     blurRadius: 8.0,
  //     color: Colors.black87)],
);
const TextStyle tsForecast = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: Colors.black,
);
const TextStyle tsBLackRock = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w400,
  fontSize: 18,
);
const TextStyle tsMini = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w600,
  fontSize: 15,
  color: Colors.white,
  // shadows: [Shadow(
  //     offset: Offset(4.0, 4.0),
  //     blurRadius: 8.0,
  //     color: Colors.deepPurple)],
);

const Color clr1 = Color(0xFFffe142);
const Color clr2 = Color(0xFF42c6ff);
const Color clr3 = Color(0xFFff64d4);
const Color clr4 = Color(0xFF32D463);
const List<Color> colors = [clr1, clr2, clr3, clr4];

const LinearGradient bdGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight, //Alignment(0.8, 1),
    colors: <Color>[
      clr1,
      clr2,
      clr3,
      clr4 //
    ],
    tileMode: TileMode.mirror,
);
const double brDef = 15;
const decorationFill = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(25)),
  color: Colors.black,
);
const decorationBorder = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(25)),
  border: Border.fromBorderSide(BorderSide(color: Colors.black, width: 2.5)),
);