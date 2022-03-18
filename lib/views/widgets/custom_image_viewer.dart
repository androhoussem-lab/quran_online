import 'dart:io';

import 'package:flutter/material.dart';


class CustomImageViewer extends StatelessWidget {
  final String? imagePath;
  const CustomImageViewer({Key? key, required this.imagePath}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return _showImage(context, imagePath);
  }

  Widget _showImage(BuildContext context , String? imagePath) {
    if (imagePath!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 2,color: Theme.of(context).primaryColor)
        ),
        width: MediaQuery.of(context).size.width,

        child:  Center(
          child: Text('إضغط هنا لرفع صورة الوصل' ,style: TextStyle(fontFamily: 'cairo' , fontSize: 16 , letterSpacing: 1.5 , color: Theme.of(context).primaryColor ),),
        ),
      );
    }
    return  Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 2,color: Theme.of(context).primaryColor)
      ),
      width: MediaQuery.of(context).size.width,

      child:Image.file(File(imagePath),fit: BoxFit.fill,),
    );


  }
}
