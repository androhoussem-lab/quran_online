
class CourseModel{
  int? id,videosCount;
  String? name, imageUrl, videoUrl, description , teacher;
  double? price ;


  CourseModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.videoUrl,
      required this.description,
        required this.teacher,
      required this.videosCount,
      required this.price});


  CourseModel.fromJson(Map<String,dynamic> jsonObject){
    id = jsonObject['id'];
    name = jsonObject['name'];
    description = jsonObject['description'];
    teacher = jsonObject['prof'];
    imageUrl = jsonObject['link_photo'];
    videoUrl = jsonObject['link_video'];
    videosCount = jsonObject['nombre_video'];
    price = double.parse(jsonObject['price']);
  }


  Map<String, dynamic> toMap() {

    return {
      'id' : id,
      'name' : name,
      'description' : description ,
      'teacher' : teacher,
      'image_url' : imageUrl,
      'video_url' : videoUrl,
      'video_count' : videosCount,
      'price' : price
    };
  }
}
