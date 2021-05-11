import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/Data.dart';

class MyFavorite extends StatefulWidget {
  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  List<Data> dataList = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FavoriteFun();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff2fc3),
        title: Text("MyFavoriate",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: dataList.length == 0
          ? Center(
        child: Text("No Data Avaliable", style: TextStyle(fontSize: 30),),)
          : ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (_, index) {
            return CardUI(dataList[index].imgurl, dataList[index].name,
                dataList[index].material, dataList[index].price,
                dataList[index].uploadid, index);
          }
      ),
    );
  }
  Widget CardUI(String imgurl, String name, String material, String price,
      String uploadId, int index) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(15),
      color: Color(0xffff2fc3),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(1.5),
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.network(imgurl, fit: BoxFit.cover, height: 100,),
            SizedBox(height: 1,),
            Text(name, style: TextStyle(color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold),),
            SizedBox(height: 1,),
            Text("material:. $material "),
            SizedBox(height: 1,),
            Container(
                width: double.infinity,
                child: Text(price, style: TextStyle(color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold), textAlign: TextAlign.right,)
            ),
            SizedBox(height: 1,),
            IconButton(
                icon: Icon(Icons.favorite, color: Colors.red,), onPressed: () {
              auth.currentUser().then((value) {
                DatabaseReference favref = FirebaseDatabase.instance.reference()
                    .child(
                    "Data").child(uploadId).child("Fav")
                    .child(value.uid)
                    .child("state");
                favref.set("false");
                setState(() {
                  FavoriteFun();
                });
              });
            }),
          ],
        ),
      ),
    );
  }

  void FavoriteFun() {
    DatabaseReference referenceData = FirebaseDatabase.instance.reference()
        .child("Data");
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;
      for (var key in keys) {
        Data data = new Data(
          values [key] ["imgurl"],
          values [key] ["name"],
          values [key] ["material"],
          values [key] ["price"],
          key,
          // key is the uploadid
        );
        auth.currentUser().then((value) {
          DatabaseReference reference = FirebaseDatabase.instance.reference()
              .child("Data").child(key).child("Fav")
              .child(value.uid)
              .child("State");
          reference.once().then((DataSnapshot snapShot) {
            if (snapShot.value != null) {
              if(snapShot.value=="true"){
                dataList.add(data);
              }
            }
          });
        });
      }
      Timer(Duration(seconds: 1), () {
        setState(() {
          //
        });
      });
    });
  }
}
