import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:holup/app/connection/connection.dart';
import 'package:holup/app/controllers/api_controller.dart';
import 'package:http/http.dart' as http;

class FlaskDatabaseOperations {
  static Future<http.Response> register(String email, String password) async {
    String url = '${Connection.springApiURL}/register';

    try {
      return await http.post(url, body: {
        'email': email,
        'password': password,
      }).timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> signIn(String email, String password) async {
    String url = '${Connection.springApiURL}/auth';

    try {
      return await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: json.encode(
              {
                'email': email,
                'password': password,
              },
            ),
          )
          .timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<http.Response> fetchAccommodationsData({
    Map<String, dynamic> arguments,
  }) async {
    String url = '${Connection.springApiURL}/accommodations';
    String apiKey = Get.find<ApiController>().apiKey.value;
    print('${Connection.apiKeyPrefix}$apiKey');
    try {
      print(arguments);
      return await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': '${Connection.apiKeyPrefix}$apiKey',
            },
            body: json.encode(arguments),
          )
          .timeout(Duration(seconds: Connection.timeout));
    } on TimeoutException catch (_) {
      print('Connection timeout occurred');
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<http.Response> fetchCalendarEvents(int userId) async {
    String url = '${Connection.springApiURL}/calendar_events/$userId';

    try {
      return await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      ).timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<http.Response> updateCalendarEvent(CalendarEvent event) async {
    String url = '${Connection.springApiURL}/calendar_event/${event.id}';

    try {
      return await http
          .put(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(event.toJson()),
          )
          .timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
