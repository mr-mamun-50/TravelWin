import 'package:flutter/material.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/views/user/dashboard.dart';
import 'package:user_flutter/views/user/favourites.dart';
import 'package:user_flutter/views/user/profile.dart';
import 'package:user_flutter/views/user/search.dart';
import 'package:user_flutter/views/welcome.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("User Home"),
      ),
      body: currentIndex == 0
          ? UserDashBoard()
          : currentIndex == 1
              ? UserSearch()
              : currentIndex == 3
                  ? UserFavourites()
                  : currentIndex == 4
                      ? UserProfile()
                      : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.explore),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 7,
        elevation: 10,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "Favorite",
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
              leading: Icon(Icons.hotel),
              title: Text("Hotels / Resorts"),
            ),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text("Transport Rent"),
            ),
            ListTile(
              leading: Icon(Icons.live_help),
              title: Text("Tourist Guides"),
            ),
            ListTile(
              leading: Icon(Icons.cloud_sync),
              title: Text("Weather Information"),
            ),
            ListTile(
              leading: Icon(Icons.flight),
              title: Text("Flight Information"),
            ),
            ListTile(
              leading: Icon(Icons.translate),
              title: Text("Language Dictionary"),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () async {
                await logout();
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
