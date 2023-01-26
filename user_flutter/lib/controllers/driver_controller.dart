import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:user_flutter/models/driver.dart';
import 'package:user_flutter/models/hotel.dart';

//__login__
Future<ApiResponse> driverLogin(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(driverLoginURL),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Driver.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = "$somethingWrong ${response.statusCode}";
        break;
    }
  } catch (e) {
    apiResponse.error = "$serverError $e";
  }

  return apiResponse;
}

//__register__
Future<ApiResponse> driverRegister(
    String name, String phone, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(driverRegisterURL),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Driver.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        apiResponse.error = "$somethingWrong ${response.statusCode}";
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

//__user__
Future<ApiResponse> getDriverDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getDriverToken();
    final response = await http.get(
      Uri.parse(driverURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Driver.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

//__get token__
Future<String> getDriverToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('driverToken') ?? '';
}

//__logout__
Future<bool> driverLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.remove('driverToken');
}
