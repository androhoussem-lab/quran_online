
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quran_online/controllers/video_controller.dart';
import 'package:get_storage/get_storage.dart';

class DownloadService {
  static final VideoController _contentController = Get.put(VideoController());
  static final GetStorage _downloadBox = GetStorage('document_data');


  static final Dio _dio = Dio();

  static Future<void> downloadFile({required BuildContext context,required String savePath,required int documentId ,required String url,required String documentName}) async {
    try {
      _contentController.downloadState('onDownload');
      _dio.download(url, savePath, onReceiveProgress: (rcv, total) {
        print(
            'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');
        _contentController.progress(double.parse(((rcv / total) * 100).toStringAsFixed(0)));
      }).then((value){
        _contentController.progress(100);
        _contentController.downloadState('downloaded');
        _saveDocumentInfoToDatabase(documentId, documentName);
        Fluttertoast.showToast(
            msg: 'تم تحميل الملف بنجاح $savePath',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      });
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
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  static _saveDocumentInfoToDatabase(int documentId , String documentName){
    _downloadBox.write('download_${documentId}_$documentName', 'downloaded');
  }
}
