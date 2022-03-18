import 'package:dio/dio.dart';
import 'package:quran_online/consts/api_end_points.dart';
import 'package:quran_online/models/course_model.dart';
import 'package:quran_online/models/payment_model.dart';
import 'package:quran_online/models/video_model.dart';
import 'exceptions.dart';

late Dio _dio;

class ApiServices {
  static ApiServices? _instance;

  ApiServices._();

  static ApiServices get instance {
    _instance ??= ApiServices._();
    return _instance!;
  }

  final Map<String, dynamic> _headers = {
    'accept': 'application/json',
    'content_type': 'multipart/form-data',
  };

  void init() {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: _headers));
  }



  Future<PaymentModel?> makePayment(Map<String, dynamic> paymentData) async {
    FormData formData = FormData.fromMap(paymentData);
    try{
      Response response = await _dio.post(
        'payment',
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PaymentModel.fromJson(response.data);
      } else {
        throwExceptionByStatusCode(response.statusCode!);
        return null;
      }
    }on Exception catch(e) {
      print(e);
      throw Exception(e.toString());
    }

  }

  Future<List<dynamic>?> getAllCourses()async{
    try{
      Response response = await _dio.get('formations');
      if(response.statusCode == 200 || response.statusCode == 201){
        List<CourseModel> courses = [];
          for(var course in response.data){
            courses.add(CourseModel.fromJson(course));
          }
        return courses;
      }else {
        throwExceptionByStatusCode(response.statusCode!);
        return null;
      }
      
    }on Exception catch(e){
      throw Exception(e.toString());
    }
  }


  Future<List<dynamic>?> getVideosByCourseId(int courseId)async{
    try{
      Response response = await _dio.get('videos_by_idFormations/$courseId');
      if(response.statusCode == 200 || response.statusCode == 201){
        List<VideoModel> videos = [];
          for(var video in response.data){
            videos.add(VideoModel.fromJson(video));
          }
        return videos;
      }else {
        throwExceptionByStatusCode(response.statusCode!);
        return null;
      }

    }on Exception catch(e){
      throw Exception(e.toString());
    }
  }




  void throwExceptionByStatusCode(int statusCode) {
    switch (statusCode) {
      case 300:
      case 301:
      case 302:
        throw RedirectionException();
      case 400:
      case 401:
      case 404:
        throw BadRequestException();
      case 500:
      case 501:
      case 502:
        throw BadGatewayException();
      case 504:
        throw GatewayTimeout();
      default:
        throw Exception('${statusCode} ${statusCode}');
    }
  }
}
