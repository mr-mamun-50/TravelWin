// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:user_flutter/controllers/driver_controller.dart';
import 'package:user_flutter/controllers/hotel_controller.dart';
import 'package:user_flutter/controllers/tourist_guide_controller.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/views/driver/home.dart';
import 'package:user_flutter/views/hotel/home.dart';
import 'package:user_flutter/views/tourist_guide/home.dart';
import 'package:user_flutter/views/user/home.dart';
import 'package:user_flutter/views/welcome.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void loadUserInfo() async {
    if (await getToken() != '') {
      ApiResponse userResponse = await getUserDetail();
      if (userResponse.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const UserHome()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${userResponse.error}'),
        ));
      }
    } else if (await getGuideToken() != '') {
      ApiResponse guideResponse = await getGuideDetail();
      if (guideResponse.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const TouristGuideHome()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${guideResponse.error}'),
        ));
      }
    } else if (await getHotelToken() != '') {
      ApiResponse hotelResponse = await getHotelDetail();
      if (hotelResponse.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HotelHome()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${hotelResponse.error}'),
        ));
      }
    } else if (await getDriverToken() != '') {
      ApiResponse driverResponse = await getDriverDetail();
      if (driverResponse.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DriverHome()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${driverResponse.error}'),
        ));
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Welcome()), (route) => false);
    }
  }

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
