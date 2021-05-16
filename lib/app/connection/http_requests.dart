import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:holup/app/models/calendar_event_dto.dart';
import 'package:http/http.dart' as http;

import 'connection.dart';

class FlaskDatabaseOperations {
  static final baseUrl = GetPlatform.isIOS
      ? Connection.springApiUrlIos
      : Connection.springApiUrlAndroid;

  static Future<http.Response> register(String email, String password) async {
    final url = '$baseUrl/register';
    try {
      return await http.post(url, body: {
        'email': email,
        'password': password,
      }).timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> signIn(
    int convictedNumber,
    String password,
  ) async {
    final url = '$baseUrl/auth';
    try {
      return await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: json.encode(
              {
                'convictedNumber': convictedNumber,
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
    final url = '$baseUrl/accommodations';
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

  static Future<http.Response> fetchCalendarEvents(
    String uuid,
    String apiKey,
  ) async {
    final url = '$baseUrl/calendar_events/$uuid';
    try {
      return await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'api-key $apiKey',
        },
      ).timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<http.Response> addCalendarEvent({
    @required String uuid,
    @required String apiKey,
    @required CalendarEventDTO calendarEventDTO,
  }) async {
    final url = '$baseUrl/calendar_event/$uuid';
    try {
      return await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'api-key $apiKey',
            },
            body: calendarEventDTO.toJson(),
          )
          .timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<http.Response> updateCalendarEvent(
    int id,
    String apiKey,
  ) async {
    final url = '$baseUrl/calendar_event/$id';
    try {
      return await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'api-key $apiKey',
        },
      ).timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<http.Response> deleteCalendarEvent(
    int id,
    String apiKey,
  ) async {
    final url = '$baseUrl/calendar_event/$id';
    try {
      return await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'api-key $apiKey',
        },
      ).timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<http.Response> fetchReleaseDate(
    String uuid,
    String apiKey,
  ) async {
    final url = '$baseUrl/release/$uuid';
    try {
      return await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'api-key $apiKey',
        },
      ).timeout(Duration(seconds: Connection.timeout));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
