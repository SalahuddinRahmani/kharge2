import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('data');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:Splash() ,));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds:1 ), () {

      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(),));

      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => InputPage(),
      //     maintainState: false,
      //   ),
      // );
    });
    return
       Scaffold(
body: SafeArea(
  child: Align(
    alignment: Alignment.center,
    child: Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Image.asset("images/aaa.jpg",fit:BoxFit.cover
        ),
        Positioned(
          top: 200,
          bottom: 55,
          //// Shimer
          child: Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Colors.white,
            child: Column(
              children: [
                Text(
                  'به برنامه',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),Text(
                  '❤ حساب روزانه  ❤',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),Text(
                  '!خوش آمدید',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),
              ],
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