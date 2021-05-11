import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LogInScreen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    NavigateToLogIn();
    // Add code after super
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyImage(),
                      Text("scarves store",style: TextStyle(fontSize: 25,),),
                    ],
                  )
              ),
              Expanded
                (
                flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 20,),
                  Text("Online Store every one "
                    ,style: TextStyle(
                        fontStyle: FontStyle.italic
                        ,fontSize: 15
                        ,color: Color(0xffffffff)),)
                ],
              ))
            ],
          ),
        ),
    );
  }
  // ignore: non_constant_identifier_names
  void NavigateToLogIn(){
    Timer(Duration(seconds: 5),()=>Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) =>LogInScreen())
    ));

  }
}

class MyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage image = new AssetImage('images/shop.jpg');
    // ignore: non_constant_identifier_names
    Image Logo = new Image(image: image,width: 70,height: 70,);
    return Logo;
  }
}

