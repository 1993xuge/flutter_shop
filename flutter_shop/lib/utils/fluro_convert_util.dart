import 'dart:convert';

/// 路由跳转时  参数 解析
class FluroConvertUtil {
  // Object 转为 String Json
  static String objectToString<T>(T t) {
    return fluroCnParamsEncode(jsonEncode(t));
  }

  //String Json转为Map
  static Map<String, dynamic> stringToMap(String str) {
    return json.decode(fluroCnParamsDecode(str));
  }

  //Fluro传递中文参数前先转换,Fluro不支持中文传递
  static fluroCnParamsEncode(String originalCn) {
    return jsonEncode(Utf8Encoder().convert(originalCn));
  }

  //Fluro传递后取出参数解析
  static fluroCnParamsDecode(String encodeCn) {
    var list = List<int>();
    jsonDecode(encodeCn).forEach(list.add);
    String value = Utf8Decoder().convert(list);
    return value;
  }
}
