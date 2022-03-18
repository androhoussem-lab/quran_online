import 'package:quran_online/models/user_model.dart';

class PaymentModel{
  late UserModel user;
  late String imageName, deviceName, createdAt;
  late int courseId;

  PaymentModel(
      {required this.user,
      required this.imageName,
      required this.deviceName,
      required this.createdAt,
      required this.courseId});

  PaymentModel.fromJson(Map<String, dynamic> jsonObject) {
    user = UserModel(
        firstName: jsonObject['nom'],
        lastName: jsonObject['prenom'],
        email: jsonObject['email'],
        mobile: jsonObject['telephone']);
    imageName = jsonObject['name_image'];
    deviceName = jsonObject['device_name'];
    createdAt = jsonObject['created_at'];
    courseId = int.parse(jsonObject['formation_id']);
  }

   Map<String, dynamic> toMap() {
    return {
      'nom': user.firstName,
      'prenom': user.lastName,
      'email': user.email,
      'telephone': user.mobile,
      'name_image': imageName,
      'device_name': deviceName,
      'formation_id': courseId,
    };
  }
}
