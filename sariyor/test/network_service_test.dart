import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sariyor/features/events/models/event_response_model.dart';

import 'package:sariyor/utils/web_service/web_service.dart';

void main() {
  var service = WebService.getInstance();
  group('Event Network Test', () {
    test('Get Event', () async {
      var response = await service.post('/event/get', data: {"id": 3  });
      bool status = response.data['success'];
      String message = response.data['message'];
      List<dynamic>? data = response.data['data'];
      List<String>? errors = response.data['errors'];
      List<EventResponse> models =
          data!.map((data) => EventResponse.fromJson(data!)).toList();
      // var model = EventResponse.fromJson(json.decode(response.data['data']));
      expect(models[0].imagePath, isNull);
    });
  });
}
