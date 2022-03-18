class RedirectionException implements Exception{
  @override
  String toString() {
    return '301 تم العثور على إعادة توجيه';
  }
}
class NotFoundException implements Exception{

  @override
  String toString() {
    return '404 غير موجود';
  }
}
class BadRequestException implements Exception{

  @override
  String toString() {
    return '400 طلب سىء';
  }
}
class ServerErrorException implements Exception{

  @override
  String toString() {
    return '500 خطأ خادم داخلي';
  }
}
class NotImplementedException implements Exception{

  @override
  String toString() {
    return '501 لم يتم التنفيذ';
  }
}
class BadGatewayException implements Exception{

  @override
  String toString() {
    return '502 مدخل غير صالح';
  }
}
class GatewayTimeout implements Exception{

  @override
  String toString() {
    return 'البوابة 504 انتهى الزمن';
  }
}