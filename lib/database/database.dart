import 'package:get_storage/get_storage.dart';


class DataBase{

  Future init()async{
    await GetStorage('payment_data').initStorage;
    await GetStorage('account_data').initStorage;
  }
}