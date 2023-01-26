import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:user_flutter/models/tourist_guide.dart';

//__login__
Future<ApiResponse> guideLogin(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(guideLoginURL),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = TouristGuide.fromJson(jsonDecode(response.body));
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
Future<ApiResponse> guideRegister(
    String name, String phone, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(guideRegisterURL),
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
        apiResponse.data = TouristGuide.fromJson(jsonDecode(response.body));
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
Future<ApiResponse> getGuideDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getGuideToken();
    final response = await http.get(
      Uri.parse(guideURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = TouristGuide.fromJson(jsonDecode(response.body));
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

//__update__
Future<ApiResponse> updateGuideDetail(
    String name,
    String? phone,
    String? address,
    String? nid,
    String? rentPerHour,
    String? creditCard,
    String? photo) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getGuideToken();
    final response = await http.put(
      Uri.parse(guideUpdateURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'name': name,
        'phone': phone ?? '',
        'address': address ?? '',
        'nid': nid ?? '',
        'rent_per_hour': rentPerHour ?? '',
        'credit_card': creditCard ?? '',
        'photo': photo ?? '',
      },
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['msg'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
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

//__update latitute and longitude__
Future<ApiResponse> updateGuideLatLng(
    String? serviceArea, String? latitude, String? longitude) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getGuideToken();
    final response = await http.put(
      Uri.parse(guideUpdateServiceAreaURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'service_area': serviceArea ?? '',
        'service_area_lat': latitude ?? '',
        'service_area_lng': longitude ?? '',
      },
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['msg'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
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
Future<String> getGuideToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('guideToken') ?? '';
}

//__logout__
Future<bool> guideLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.remove('guideToken');
}
