import 'dart:async';
import 'package:bored/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(4, 4, 4, 1),
      body: Center(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/bored.svg',height: 150,width: 150,fit: BoxFit.fitHeight,color: Color.fromRGBO(255, 221, 142, 1),),
            SizedBox(
              height: 30,
            ),
            Text("Find things to do when you're",style: GoogleFonts.roboto(fontWeight: FontWeight.w300,fontSize: 19,color: Color.fromRGBO(255, 229, 168, 1)),textAlign: TextAlign.center,),
            Text("BORED!",style: GoogleFonts.roboto(fontWeight: FontWeight.w900,fontSize: 72,color: Color.fromRGBO(253, 240, 213, 1)),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}