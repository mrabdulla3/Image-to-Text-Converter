import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detailed_Page extends StatelessWidget {
  const Detailed_Page({
    Key? key,
    this.image,
  }) : super(key: key);

  final File? image;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                child:Image.file(
                        image!,
                        width: double.infinity,
                        height: screenHeight * 0.4,
                        fit: BoxFit.cover,
                      )

              ),
              Container(
                color: Colors.grey.shade100,
                height: screenHeight * 0.6,
                width: screenWidth,
                child: Center(
                  child: Text(
                    'Additional Content Here',
                    style: TextStyle(fontSize: 20, color: Colors.black),
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
