import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/calendar_event.dart';
import 'connection.dart';

class FlaskDatabaseOperations {
  static Future<http.Response> register(String email, String password) async {
    final url = '${Connection.springApiURL}/register';
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
    final url = '${Connection.springApiURL}/auth';
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
    final url = '${Connection.springApiURL}/accommodations';
    try {
      print(arguments);
      return await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
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
    final url = '${Connection.springApiURL}/calendar_events/$userId';
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
    final url = '${Connection.springApiURL}/calendar_event/${event.id}';
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
