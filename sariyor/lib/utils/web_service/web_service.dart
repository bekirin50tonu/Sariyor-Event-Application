import 'package:dio/dio.dart';
import 'package:sariyor/constants/app_constant.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
// import 'package:sariyor/utils/locale/shared_preferences.dart';

class WebService {
  static Dio getInstance() {
    Dio _inst = Dio(BaseOptions(
      responseType: ResponseType.json,
      baseUrl: AppConstants.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 10000,
    ));
    _inst.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      var token = Prefs.getString('token');
      options.headers['Accept'] = "application/json";
      options.headers['Authorization'] = "Bearer $token";
      handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        var token = Prefs.getString('token');
        error.requestOptions.headers['Authorization'] = "Bearer $token";
        final opt = Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            method: error.requestOptions.method,
            headers: error.requestOptions.headers);
        final req = await _inst.request(error.requestOptions.path,
            options: opt,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters);
        return handler.resolve(req);
      }
      if (error.response == null) {
        final opt = Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            method: error.requestOptions.method,
            headers: error.requestOptions.headers);
        final req = await _inst.request(error.requestOptions.path,
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
