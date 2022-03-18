import 'dart:io';

import 'package:http/http.dart' as http;



class HttpServices {


  static Future makePayment(Map<String,String> data , String filePath) async{

    Map<String,String> headers = {
      'content_type': 'multipart/form-data',
    };
    try{
      var request = http.MultipartRequest('POST', Uri.parse('https://aladdinshop-dz.com/api/payment'))
        ..fields.addAll(data)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', filePath));
      var response = await request.send();
      var responsea = await http.Response.fromStream(response);
      if (response.statusCode == 201 || response.statusCode == 200) {

        print(responsea.body);

        return true;
      } else {
        return false;
      }

    }on SocketException catch (e){

    }
  }


}