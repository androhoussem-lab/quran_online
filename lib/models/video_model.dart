import 'document_model.dart';

class VideoModel{

   int? id;
   String? title,description, time, videoUrl;
   List<dynamic>? documents ;

  VideoModel(
      { required this.id,
        required this.title,
        required this.description,
      required this.time,
      required this.videoUrl,
      required this.documents});

  VideoModel.fromJson(Map<String,dynamic> jsonObject){
    id = jsonObject['id'];
    title = jsonObject['title'];
    description = jsonObject['description'];
    time = jsonObject['duration_video'];
    videoUrl = jsonObject['link'];
    documents = _getDocuments(jsonObject['docuemnt']);
  }


  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'time' : time,
      'video_url' : videoUrl,
      'documents' : documents!.map((document) => DocumentModel.instance().toMap()).toList()
    };
  }
  
  
  List<DocumentModel> _getDocuments(List<dynamic> jsonDocuments){
    List<DocumentModel> documents = [];
    if(jsonDocuments.isNotEmpty){
      for(var document in jsonDocuments){
        documents.add(DocumentModel.fromJson(document));
        return documents;
      }
    }
    return documents;
  }

}
