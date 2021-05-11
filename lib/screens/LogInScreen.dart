import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppingapp/screens/ForgetScreen.dart';
import 'package:shoppingapp/screens/HomeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'SignUpScreen.dart';
class LogInScreen extends StatefulWidget {
  bool signInState = false;
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String email ="", password ="";
  var _formkey = GlobalKey<FormState>();
 static FirebaseAuth auth =FirebaseAuth.instance;

  bool get signInState => null;


  Future<String> logIn() async{
    String user = (await auth.signInWithEmailAndPassword(email: email.trim(), password: password)).toString();
    return user;
  }

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void>_GoogleSignIn() async{
    GoogleSignInAccount signInAccount =await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await signInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    FirebaseUser user = (await auth.signInWithCredential(credential)).user;
    print(user);

    setState(() {
      var signInState = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(()async{
      if(await auth.currentUser() !=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>HomeScreen(email)));
      }
    }

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
      child:ListView(
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
                Text("Log In ",
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
              child: Padding(padding: EdgeInsets.only(top:50 ,right: 20,left: 20 ),
            child: TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return "please your email";
                }else{
                  email = value;
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
            child: Padding(padding: EdgeInsets.only(top:10 ,right: 20,left: 20 ),
              child: TextFormField(
                obscureText: true,
                autocorrect: false,
                validator: (value){
                  if(value.isEmpty){
                    return "please enter your password";
                  }else if(value.length<8){
                    return "your password shouldnt be less  than 8 char ";
                  }else{
                    password = value;
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: ("Password"),
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
          Padding(padding: EdgeInsets.only(right: 20),
          child:  Container(
            width: double.infinity,
            child: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> ForgetScreen()));
              },
             child:Text("forget password",
              textAlign: TextAlign.right,
              style: TextStyle(
              color: Color(0xffff2fc3),
            ),),
          ),
          )
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
          child: RaisedButton(
              onPressed: (){
                if(_formkey.currentState.validate()){
                  Future<String> check= logIn();
                  if(check!=null) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(email)
                    ));
                  }
                }

              },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Color(0xffff2fc3),
            child:Text("Log In",style: TextStyle(color: Colors.blue,
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
              onPressed: (){
                _GoogleSignIn();
                if(signInState){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context)=>HomeScreen(email)));
                }
              },
              color: Colors.white,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.google,color: Colors.red,),
                  SizedBox(height: 10,),
                  Text("sign in with google",style: TextStyle(
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
                  Text("sign with facebook",style: TextStyle(
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
                Text("dont have any account ?",style: TextStyle(
                    color: Colors.white
                ),),
                FlatButton(onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context)=> SignUpScreen())
                  );

                },
                  child:Column(
                    children: <Widget>[
                    Text("Sign Up",style: TextStyle(
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


