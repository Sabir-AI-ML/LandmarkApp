import 'package:dio/dio.dart';

class HttpCalls {
  static apiHelper(
      {required Map<String, dynamic> body,
      required String endpoint,
      bool isJson = false}) async {
    String url = "https://c300-205-254-166-19.ngrok-free.app/";
    Dio d = Dio();
    Response r;
    try {
      var data = FormData.fromMap(body);
      r = await d.post('$url$endpoint',
          data: isJson ? body : data,
          // data: body,
          options: Options(headers: {
            'Content-Type': isJson
                ? 'application/json'
                : 'multipart/form-data; boundary=${data.boundary}',
            'Content-Length': '${isJson ? body.length : data.length}',
          }));
      return r.data;
    } catch (e) {
      print(e);
    }
    return {"status": false, "message": "No Data Found"};
  }
}
