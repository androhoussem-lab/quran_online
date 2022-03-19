import 'package:intl/intl.dart';


class DateTimeUtils {


  int getDaysBetween(String dateTime){
    DateTime now = DateTime.now();
    return now.difference(_formatDateTime(dateTime)).inDays;
  }


  DateTime _formatDateTime(String dateTime){
    return  DateFormat('yy-MM-dd').parse(dateTime);
  }

}