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


  //init dio
  void init() {
    _dio = Dio(BaseOptions(
        baseUrl: BASE_URL,
        headers: _headers,
        connectTimeout: 10000,
        receiveTimeout: 10000));
  }

  //make payment
  Future<PaymentModel?> makePayment(Map<String, dynamic> paymentData) async {
    FormData formData = FormData.fromMap(paymentData);
    try {
      Response response = await _dio.post(
        'payment',
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if(response.data['success']){
          return PaymentModel.fromJson(response.data['paiment']);
        }
      } else {
        throwExceptionByStatusCode(response.statusCode!);
        return null;
      }
    } on DioError catch (e) {

      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw Exception(
            "يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى');
        }
      } else {
        throw Exception("يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> getCourseByCode(
      Map<String, dynamic> subscriptionData) async {
    FormData formData = FormData.fromMap(subscriptionData);
    try {
      Response response = await _dio.post(
        'access_with_Code',
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throwExceptionByStatusCode(response.statusCode!);
        return null;
      }
    } on DioError catch (e) {

      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw Exception(
            "يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى');
        }
      } else {
        throw Exception("يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      }
    }
    return null;
  }

  Future<List<dynamic>?> getAllCourses() async {
    try {
      Response response = await _dio.get('formations');
      if (response.statusCode == 200 || response.statusCode == 201) {

        List<CourseModel> courses = [];
        for (var course in response.data['data']) {
          courses.add(CourseModel.fromJson(course));
        }
        return courses;
      } else {
        throwExceptionByStatusCode(response.statusCode!);
        return null;
      }
    } on DioError catch (e) {

      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw Exception(
            "يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى');
        }
      } else {
        throw Exception("يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      }
    }
    return null;
  }



  //get list of videos by course ID
  Future<List<dynamic>?> getVideosByCourseId(int courseId) async {
    try {
      Response response = await _dio.get('videos_by_idFormations/$courseId');
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<VideoModel> videos = [];
        for (var video in response.data['data']) {
          videos.add(VideoModel.fromJson(video));
        }
        return videos;
      } else {
        throwExceptionByStatusCode(response.statusCode!);
        return null;
      }
    } on DioError catch (e) {

      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw Exception(
            "يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");

      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى');
        }
      } else {
        throw Exception("يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      }
    }
    return null;
  }


  //Send review

  Future<Map<String,dynamic>?> sendReview(Map<String,dynamic> body)async{
    FormData formData = FormData.fromMap(body);
    try {
      Response response = await _dio.post(
        'reviews',
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if(response.data['success']){
          return response.data;
        }
      } else {
        throwExceptionByStatusCode(response.statusCode!);
        return null;
      }
    } on DioError catch (e) {

      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw Exception(
            "يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى');
        }
      } else {
        throw Exception("يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى");
      }
    }
    return null;
  }



  //checking and throw exception by status code
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
