import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:user_flutter/models/hotel.dart';

//__login__
Future<ApiResponse> hotelLogin(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(hotelLoginURL),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Hotel.fromJson(jsonDecode(response.body));
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
Future<ApiResponse> hotelRegister(
    String name, String phone, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(hotelRegisterURL),
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
        apiResponse.data = Hotel.fromJson(jsonDecode(response.body));
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
Future<ApiResponse> getHotelDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getHotelToken();
    final response = await http.get(
      Uri.parse(hotelURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Hotel.fromJson(jsonDecode(response.body));
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
Future<ApiResponse> updateHotelDetail(String name, String? phone, int? rooms,
    String? creditCard, String? logo) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getHotelToken();
    final response = await http.put(
      Uri.parse(hotelUpdateURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'name': name,
        'phone': phone ?? '',
        'number_of_rooms': rooms,
        'credit_card': creditCard ?? '',
        'photo': logo ?? '',
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

//__update latitude longitude__
Future<ApiResponse> updateHotelLatLng(
    String? address, String? latitude, String? longitude) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getHotelToken();
    final response = await http.put(
      Uri.parse(hotelUpdateAddressURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'service_area': address ?? '',
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
Future<String> getHotelToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('hotelToken') ?? '';
}

//__logout__
Future<bool> hotelLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.remove('hotelToken');
}
