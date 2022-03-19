import 'package:get_storage/get_storage.dart';


class DataBase{



  static Future init()async{
    await GetStorage.init('payment_data');
    await GetStorage.init('account_data');
  }
}