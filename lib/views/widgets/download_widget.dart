import 'package:flutter/material.dart';


class DownloadWidget extends StatelessWidget {
  const DownloadWidget({Key? key , required this.downloadState , required this.progress}) : super(key: key);
  final String downloadState;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return _buildDownloadWidget(context);
  }
  Widget _buildDownloadWidget(BuildContext context){
    if(downloadState=='ready'){
      return Icon(Icons.arrow_circle_down, size: 24, color: Theme.of(context).primaryColor,);
    } else if(downloadState=='onDownload'){
      return CircularProgressIndicator(
        value: progress,
        color: Colors.white,
        strokeWidth: 4,
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      );
    }else{
      return Icon(Icons.visibility , size: 24, color: Theme.of(context).primaryColor,);
    }
  }
}
