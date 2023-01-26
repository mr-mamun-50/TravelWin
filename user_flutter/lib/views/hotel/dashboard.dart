import 'package:flutter/material.dart';

class HotelDashboard extends StatefulWidget {
  const HotelDashboard({super.key});

  @override
  State<HotelDashboard> createState() => _HotelDashboardState();
}

class _HotelDashboardState extends State<HotelDashboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hotel Dashboard"),
    );
  }
}
