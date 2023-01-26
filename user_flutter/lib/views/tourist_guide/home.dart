import 'package:flutter/material.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/tourist_guide_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/tourist_guide.dart';
import 'package:user_flutter/views/tourist_guide/dashboard.dart';
import 'package:user_flutter/views/tourist_guide/profile.dart';
import 'package:user_flutter/views/welcome.dart';

class TouristGuideHome extends StatefulWidget {
  const TouristGuideHome({super.key});

  @override
  State<TouristGuideHome> createState() => _TouristGuideHomeState();
}

class _TouristGuideHomeState extends State<TouristGuideHome> {
  int currentIndex = 0;
  TouristGuide? guide;
  bool loading = true;

  //__get user__
  Future<void> _getGuideDetail() async {
    ApiResponse apiResponse = await getGuideDetail();

    if (apiResponse.error == null) {
      setState(() {
        guide = apiResponse.data as TouristGuide;
        loading = false;
      });
    } else if (apiResponse.error == unauthorized) {
      guideLogout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Welcome()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(apiResponse.error!),
      ));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getGuideDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tourist Guide Home'),
      ),
      body: currentIndex == 0
          ? GuideDashboard()
          : currentIndex == 3
              ? GuideProfile()
              : Container(),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () {},
      //     child: Icon(Icons.explore),
      //   ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: guide?.photo == null
                        ? const NetworkImage(
                            'https://www.pngitem.com/pimgs/m/130-1300253_female-user-icon-png-download-user-image-color.png')
                        : NetworkImage(
                            '$imgURL/profile_pictures/${guide!.photo!}'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    guide?.name ?? "",
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
                await guideLogout();
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
