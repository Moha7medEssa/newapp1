

import 'dart:collection';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
class UpLoadData extends StatefulWidget {
  @override
  _UpLoadDataState createState() => _UpLoadDataState();
}

class _UpLoadDataState extends State<UpLoadData> {
  var formkey = GlobalKey<FormState>();
  String name, material, pricre ;
  File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00725),
      appBar: AppBar(
        backgroundColor: Color(0xffff2fc3),
        title: Text("UpLoad Data",style: TextStyle(color: Color(0xffffffff)),),
      ),
      body: Form(
        key: formkey,
     child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15)),
            Container(
              child: imageFile==null?
              FlatButton(
                  onPressed: (){
                    _showDialog();
                  },
                  child: Icon(Icons.add_a_photo,size: 50,color: Color(0xffff2fc3),)
              ):
              Image.file(imageFile,width:400,height: 400,),
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                SizedBox(width: 5,),
                Expanded(
                  flex: 1,
                  child: Theme(
                    data: ThemeData(
                      highlightColor: Colors.blue,
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "please write the name of production";
                        }else{
                          name = value;
                        }
                      },

                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Name",
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
                          ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 5,),
                Expanded(
                  flex: 1,
                  child: Theme(
                    data: ThemeData(
                      highlightColor: Colors.blue,
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "please write the material of production";
                        }else{
                          material = value;
                        }
                      },

                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "material",
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
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 5,),
                Expanded(
                  flex: 1,
                  child: Theme(
                    data: ThemeData(
                      highlightColor: Colors.blue,
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "please write the price of production";
                        }else{
                          pricre = value;
                        }
                      },

                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "price",
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
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 5,),
              ],
            ),
            SizedBox(height: 10,),
            RaisedButton(
              onPressed: (){
                if(imageFile == null){
                  Fluttertoast.showToast(
                      msg: "please select an image",
                    gravity: ToastGravity.CENTER,
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 2
                  );
                }else{
                  upload();
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color(0xffff2fc3),
              child: Text('Upload',style: TextStyle(fontSize: 18,color: Colors.blue),),
            )
          ],
        ),
      ),
      ),
    );
  }
  Future<void>_showDialog(){
    return showDialog(context: context,builder: (BuildContext){
      return AlertDialog(
        title: Text('you want take a photo from? '),
        content: SingleChildScrollView(
         child:ListBody(
          children: <Widget>[
            GestureDetector(
              child: Text('Gallary'),
              onTap: (){openGallary();},
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            GestureDetector(
              child: Text('Camera'),
              onTap: (){openCamera();},
            ),
          ],
        ),
      ),
      );
      });
  }

  Future<void>openGallary() async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture ;
    });
  }
  Future<void>openCamera() async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture ;
    });
  }

  Future<void> upload() async {
    if (formkey.currentState.validate()) {
      StorageReference reference = FirebaseStorage.instance.ref().child(
          "images")
          .child(new DateTime.now().millisecondsSinceEpoch.toString() + "." +
          imageFile.path);
      StorageUploadTask uploadTask = reference.putFile(imageFile);

      var imageurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      String url = imageurl.toString();
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .reference()
          .child("Data");
      String uploadId = databaseReference
          .push()
          .key;
      HashMap map = new HashMap();
      map ["name"] = name;
      map ["material"] = material;
      map ["price"] = pricre;
      map ["imageUrl"] = url;

      databaseReference.child(uploadId).set(map);
    }
  }
  }



