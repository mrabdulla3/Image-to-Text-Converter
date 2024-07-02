import 'dart:io';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_detector/splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_detector/Detailed_Page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;
  bool selectImage = false;
  bool cameraClicked = false;

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
      selectImage = true;
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
      selectImage = true;
    });
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(13),
                    bottomLeft: Radius.circular(13))),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'Medicine Detector',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            )),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: selectImage
              ? Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  child: _selectedImage != null
                      ? Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80),
                            child: SizedBox(
                                height: screenHeight,
                                width: screenWidth,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ))),
                          ),
                          Positioned(
                              top: 10,
                              left: 5,
                              child: TextButton(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      size: 40,
                                      color: Colors.white,
                                    )),
                                onPressed: () {
                                  if (_selectedImage != null) _removeImage();
                                  selectImage = false;
                                },
                              )),
                          Positioned(
                              bottom: 10,
                              left: 50,
                              right: 50,
                              child: Container(
                                height: 60,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Detailed_Page(
                                                image: _selectedImage),
                                          ));
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black)),
                                    child: Text(
                                      "Medicine Info",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    )),
                              ))
                        ])
                      : const Text(
                          'Please Select an Image',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                )
              : Container(),
        ),
        SizedBox(
          height: screenHeight * 0.1,
        )
      ]),
      floatingActionButton: CircularMenu(
        alignment: Alignment.bottomCenter,
        toggleButtonColor: Colors.blue,
        items: [
          CircularMenuItem(
            icon: Icons.photo_album_outlined,
            color: Colors.green,
            onTap: () {
              _pickImageFromGallery();
              cameraClicked = true;
            },
          ),
          CircularMenuItem(
            icon: Icons.camera_alt_outlined,
            color: Colors.red,
            onTap: () {
              if (_selectedImage == null) _pickImageFromCamera();
              cameraClicked = true;
            },
          ),
          CircularMenuItem(
            icon: Icons.rotate_right_outlined,
            color: Colors.orange,
            onTap: () {
              cameraClicked ? _pickImageFromCamera() : '';
            },
          ),
        ],
      ),
    );
  }
}
