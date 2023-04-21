import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/weather_screen.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);
  static const String route = 'city';

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _controller = TextEditingController();
  late final Color currentClr;

  @override
  void initState() {
    var colors = [clr1, clr2, clr3, clr4];
    currentClr = colors[Random().nextInt(colors.length)];
    _controller.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: currentClr,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                  tag: 'up',
                  child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          decoration:  BoxDecoration(
                            gradient: bdGradient,
                            border: Border.all(color: Colors.white,width: 3,),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(brDef)),
                            //color: Colors.black,
                          ),
                          child: const Center(
                            child: Text(
                              'Погода',
                              style: tsCity,
                            ),
                          ),),),),
              const SizedBox(height: 25),
              Hero(
                tag: 'black',
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(brDef)),
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Введите город',
                              hintStyle: tsLite.copyWith(color: currentClr),
                            ),
                            style: tsLite.copyWith(color: currentClr),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            context
                                .read<WeatherBloc>()
                                .add(CityEvent(_controller.text));
                            context
                                .read<WeatherBloc>()
                                .add(LoadWeatherEvent());
                            Navigator.pushReplacementNamed(
                                context, WeatherScreen.route);
                          },
                          child: Icon(
                            CupertinoIcons.tornado,
                            size: 30,
                            color: currentClr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
