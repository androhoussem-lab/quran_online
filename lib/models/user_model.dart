

class UserModel{
  late String firstName,lastName,email,mobile;


  UserModel({required this.firstName, required this.lastName, required this.email, required this.mobile});

  UserModel.fromJson(Map<String,dynamic> jsonObject){
    firstName = jsonObject['nom'];
    lastName = jsonObject['prenom'];
    email = jsonObject['email'];
    mobile = jsonObject['telephone'];
  }


  Map<String, dynamic> toMap() {
    return {
      'nom' : firstName ,
      'prenom' : lastName ,
      'email' : email ,
      'telephone' : mobile
    };
  }



}