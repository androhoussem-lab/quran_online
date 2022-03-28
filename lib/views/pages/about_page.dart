import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text(
          'عن التطبيق',
          style: TextStyle(fontFamily: 'cairo'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/app_icon.png' , width: 350,height: 250,fit: BoxFit.fill,),
                Text(
                  'فريقنا في خدمة القرآن و خدمتكم لمزيد من المعلومات يرجى الاتصال بالرقم :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'cairo' , fontSize: 20),
                ),
                GestureDetector(
                  onTap: (){
                    launcher.launch('tel:0674186895');
                  },
                  child: Text(
                    '0674186895',
                    style: TextStyle(fontFamily: 'cairo' , fontSize: 20 , fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'أو التواصل معنا عن طريق البريد الإلكتروني :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'cairo' , fontSize: 20),
                ),
                GestureDetector(
                  onTap: (){
                    launcher.launch('mailto:ayhamorganisation@hotmail.com');
                  },
                  child: Text(
                    'ayhamorganisation@hotmail.com',
                    style: TextStyle(fontFamily: 'cairo' , fontSize: 20 , fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
