import 'package:http/http.dart' as http;

abstract class RequestInterceptor {
  Future<http.Request> onRequest(http.Request request);
}

abstract class ResponseInterceptor {
  Future<http.Response> onResponse(http.Response response);
}
