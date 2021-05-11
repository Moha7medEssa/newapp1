import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppingapp/screens/LogInScreen.dart';

import 'HomeScreen.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email ="", password ="";
  var _formkey = GlobalKey<FormState>();
  FirebaseAuth auth =FirebaseAuth.instance;
  Future<Void> regiser() async{
     await auth.createUserWithEmailAndPassword(email: email.trim(), password: password).then((value){
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context)=> HomeScreen(value.user.email)
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Form(
        key: _formkey,
      child: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 180,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  SizedBox(height: 50,),
                  Text("Sign Up ",
                    style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),
                  ),
                  Text("Welcome to our store",
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                ],
              ),

            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(150)),
              color: Color(0xffff2fc2),
            ),
          ),
          Theme(
            data: ThemeData(
                highlightColor: Colors.blue
            ),
            child: Padding(padding: EdgeInsets.only(top:10 ,right: 20,left: 20 ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if(value.isEmpty){
                    return "please enter user name";
                  }else {
                    email = value;
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: ("User Name"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    )
                ),
              ),
            ),
          ),


          Theme(
            data: ThemeData(
                highlightColor: Colors.blue
            ),
            child: Padding(padding: EdgeInsets.only(top:10 ,right: 20,left: 20 ),
              child: TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "please enter Email";
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: ("Email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    )
                ),
              ),
            ),
          ),
          Theme(
            data: ThemeData(
                highlightColor: Colors.blue
            ),
            child: Padding(padding: EdgeInsets.only(top:50 ,right: 20,left: 20 ),
              child: TextFormField(
                obscureText: true,
                autocorrect: false,
                validator: (value){
                  if(value.isEmpty){
                    return "please enter password";
                  }else if(value.length<8){
                    return "your password shouldnt be less  than 8 char";
                  }else {
                    password = value;
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: ("password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xffff2fc3),width: 1)
                    )
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),
          Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: RaisedButton(
                onPressed: (){
                  if(_formkey.currentState.validate()){
                   regiser();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Color(0xffff2fc3),
                child:Text("Sign Up",style: TextStyle(color: Colors.blue,
                    fontWeight: FontWeight.bold,fontSize: 20),),
                padding: EdgeInsets.all(10),
              )
          ),
          SizedBox(height: 20,),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.blue,
          ),
          Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20),
            child: RaisedButton(
              onPressed: (){},
              color: Colors.white,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.google,color: Colors.red,),
                  SizedBox(height: 10,),
                  Text("sign up with google",style: TextStyle(
                      fontSize: 20,color: Color(0xff000725)
                  ),)
                ],
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20),
            child: RaisedButton(
              onPressed: (){},
              color: Colors.white,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.facebook,color: Colors.blue,),
                  SizedBox(height: 10,),
                  Text("sign up with facebook",style: TextStyle(
                      fontSize: 20,color: Color(0xff000725)
                  ),)
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Center(
              child: Column(
                children: <Widget>[
                  Text("you already have any account ?",style: TextStyle(
                      color: Colors.white
                  ),),
                  FlatButton(onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context)=> LogInScreen())
                    );

                  },
                    child: Column(
                      children: <Widget>[
                      Text("Log In",style: TextStyle(
                        color: Colors.blue
                    ),),
                  Container(
                    width: 45,
                    height: 1,
                    color: Colors.blue,
                  )
                      ],
                    ),

                  )
              ]

          ),

          ),
        ]),

    ),
      backgroundColor: Colors.indigoAccent,
    );
  }
}
