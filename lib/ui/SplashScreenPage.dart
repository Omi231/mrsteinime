import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrsteinime/main.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {


  startSplashScreen()async{
    var duration=const Duration(seconds: 5);
    return Timer(duration,(){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (x){
          return MyHomePage(title: "Mr.Stein",context: x,);
        })
      );
    });
  }
  @override
  void initState() {
    // startSplashScreen();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: Container(
            color: Colors.black,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/icon.png",width: 200,),
               
                Text("Streaming Anime Subtitle Indonesia",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
              ],
            ),
          ),
    );
  }
}