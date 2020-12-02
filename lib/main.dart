import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:food_nutritions/loading.dart';

DateTime now ;
String formattedDate;
//import 'package:firebase_storage/firebase_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutritionist app',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        accentColor: Colors.white,

        fontFamily: 'Arial',

      ),
      home: MyHomePage(title: 'The Nutritionist'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _uploaded = false;
  bool load = false;
  File _image;
  String Msg = "Load Image";
//  StorageReference reference = FirebaseStorage.instance.ref().child('img'+formattedDate+'.jpg');
  Future getImage() async{
    final image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future uploadimage () async{
    now = DateTime.now();
    formattedDate = DateFormat('MM-dd-kk:mm').format(now);
    StorageReference reference = FirebaseStorage.instance.ref().child(formattedDate+'.jpg');
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      _uploaded = true;
      load = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return load?Loading():Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body:

      Container(
        alignment: Alignment.topCenter,
        child: Center(
            child: _image==null ? Text(Msg, style: TextStyle(fontSize: 25),) : Image.file(_image)
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: () {
                if (_image != null) {
                  setState(() => load = true);
                  uploadimage();
                  _image = null;
                  Msg = "Image uploaded";
                }
                else{
                  Msg = "First upload an image";
                }
              },
              tooltip: 'Increment',
              icon: Icon(Icons.file_upload,size: 30,),
              label: Text('Upload',style: TextStyle(fontSize:15),),
              backgroundColor:   Colors.cyan[300],
            ),
            FloatingActionButton.extended(
              onPressed: getImage,
              tooltip: 'Increment',
              icon: Icon(Icons.add_a_photo, size: 30,),
              label: Text('Add image',style: TextStyle(fontSize:15),),
              backgroundColor: Colors.cyan[300],
            ),
          ],
        ),
      ),



      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}