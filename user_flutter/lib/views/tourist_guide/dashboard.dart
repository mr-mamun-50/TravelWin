import 'package:flutter/material.dart';

class GuideDashboard extends StatefulWidget {
  GuideDashboard({Key? key}) : super(key: key);

  @override
  State<GuideDashboard> createState() => _GuideDashboardState();
}

class _GuideDashboardState extends State<GuideDashboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Guide Dashboard"),
    );
  }
}
