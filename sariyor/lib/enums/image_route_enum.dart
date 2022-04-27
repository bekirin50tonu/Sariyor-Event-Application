import 'package:sariyor/constants/app_constant.dart';

enum ImageRouteType { profile, event, category }

extension ImageRouteExtension on ImageRouteType {
  String url(String? path) {
    switch (this) {
      case ImageRouteType.profile:
        return "${AppConstants.PROFILE_IMAGE_URL}${path ?? 'dummy'}";
      case ImageRouteType.event:
        return "${AppConstants.EVENT_IMAGE_URL}${path ?? 'dummy'}";
      case ImageRouteType.category:
        return "${AppConstants.CATEGORY_IMAGE_URL}${path ?? 'dummy'}";
      default:
        return "";
    }
  }
}
