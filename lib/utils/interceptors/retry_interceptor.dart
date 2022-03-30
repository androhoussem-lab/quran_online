import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quran_online/utils/interceptors/dio_connectivity_request_retryer.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor{

  DioConnectivityRequestRetryer requestRetry;


  RetryOnConnectionChangeInterceptor({required this.requestRetry});

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async{
    if(_shouldRetry(err)){
      try{
          handler.resolve(await requestRetry.scheduleRequestRetry(err.requestOptions));
      }catch (e){
      }
    }
    super.onError(err, handler);
  }


  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }


}