import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sariyor/features/events/models/event_response_model.dart';

import 'package:sariyor/utils/web_service/web_service.dart';

void main() {
  var service = WebService.getInstance();
  group('Event Network Test', () {
    test('Get Event', () async {
      try {
        var response = await service.post('/event/get', data: {"id": 32});

        if (response.statusCode == 200) {
          bool status = response.data['success'];
          String message = response.data['message'];
          List<dynamic>? data = response.data['data'];
          List<EventResponse> models =
              data!.map((data) => EventResponse.fromJson(data!)).toList();
          expect(models[0].name, isNotNull);
        } else {
          bool status = response.data['success'];
          String message = response.data['message'];
          List<dynamic>? errors = response.data['errors'];
          expect(errors![0], isNotNull);
        }
      } on Exception catch (e) {
        log(e.toString());
      }
    });
  });
}
