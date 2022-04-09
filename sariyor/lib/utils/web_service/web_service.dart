import 'package:dio/dio.dart';
import 'package:sariyor/constants/app_constant.dart';
// import 'package:sariyor/utils/locale/shared_preferences.dart';

class WebService {
  static Dio getInstance() {
    Dio _inst = Dio(BaseOptions(baseUrl: AppConstants.BASE_URL));
    _inst.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Accept'] = "application/json";
      handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        // var token = Prefs.getString('token');
        var token = "1|yvMqAmkFaU8cq1mbCgnwNFpd0KbHwvkuIcP0dNPL";
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
      handler.next(error);
    }));
    return _inst;
  }
}
