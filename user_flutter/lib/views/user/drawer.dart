import 'package:flutter/material.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/views/user/search_guide.dart';
import 'package:user_flutter/views/welcome.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SearchGuide()),
                (route) => true),
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
    );
  }
}
