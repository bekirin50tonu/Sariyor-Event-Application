import 'dart:html';
import 'package:dio/dio.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';

class WebService {
  static Dio? _inst;

  static Dio init() {
    return _inst ?? Dio();
  }

  static Dio? getInstance() {
    _inst!.clear();
    _inst!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Accept'] = "application/json";
      handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.statusCode == HttpStatus.unauthorized) {
        var token = Prefs.getString('token');
        error.requestOptions.headers['Authorization'] = "Bearer $token";
        final opt = Options(
            method: error.requestOptions.method,
            headers: error.requestOptions.headers);
        final req = await _inst!.request(error.requestOptions.path,
            options: opt,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters);
        return handler.resolve(req);
      }
      handler.next(error);
    }));
    return _inst;
  }
}
