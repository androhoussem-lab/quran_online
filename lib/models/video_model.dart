import 'document_model.dart';

class VideoModel{

   int? id;
   String? title,description ,imageUrl, time, videoUrl;
   List<DocumentModel>? documents ;

  VideoModel(
      { required this.id,
        required this.title,
        required this.description,
      required this.imageUrl,
      required this.time,
      required this.videoUrl,
      required this.documents});

  VideoModel.fromJson(Map<String,dynamic> jsonObject){
    id = jsonObject['id'];
    title = jsonObject['title'];
    description = jsonObject['description'];
    imageUrl = jsonObject['image_url'];
    time = jsonObject['time'];
    videoUrl = jsonObject['video_url'];
    documents = DocumentModel.getDocumentListFromJson(jsonObject['documents']);
  }


  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'image_url' : imageUrl,
      'time' : time,
      'video_url' : videoUrl,
      'documents' : documents!.map((document) => DocumentModel.instance().toMap()).toList()
    };
  }

}
