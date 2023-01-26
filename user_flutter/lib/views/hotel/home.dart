import 'package:flutter/material.dart';
import 'package:user_flutter/controllers/hotel_controller.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/hotel.dart';
import 'package:user_flutter/views/hotel/dashboard.dart';
import 'package:user_flutter/views/hotel/profile.dart';
import 'package:user_flutter/views/welcome.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({super.key});

  @override
  State<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  int currentIndex = 0;
  Hotel? hotel;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Home'),
      ),
      body: currentIndex == 0
          ? HotelDashboard()
          : currentIndex == 3
              ? HotelProfile()
              : Container(),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_task),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: "Messenger",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      //   fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Search"),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () async {
                await hotelLogout();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Welcome()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
