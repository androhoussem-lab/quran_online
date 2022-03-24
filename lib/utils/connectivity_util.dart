import 'package:connectivity_plus/connectivity_plus.dart';


class ConnectivityUtil{
  static Future<bool> checkDeviceIsConnected()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}