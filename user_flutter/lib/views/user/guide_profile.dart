import 'package:flutter/material.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/tourist_guide.dart';
import 'package:user_flutter/views/user/GuideBooking.dart';
import 'package:user_flutter/views/welcome.dart';

class GuideProfileUser extends StatefulWidget {
  final int guideID;
  const GuideProfileUser(this.guideID, {super.key});

  @override
  State<GuideProfileUser> createState() => _GuideProfileUserState();
}

class _GuideProfileUserState extends State<GuideProfileUser> {
  List<dynamic> guides = [];
  bool loading = true;

  //__get user__
  Future<void> _getGuideDetail() async {
    ApiResponse apiResponse = await getAllTouristGuide();

    if (apiResponse.error == null) {
      setState(() {
        guides = apiResponse.data as List<dynamic>;
        loading = false;
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
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
    // TODO: implement initState
    _getGuideDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Profile'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: guides[widget.guideID]['photo'] != null
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    '$imgURL/profile_pictures/${guides[widget.guideID]['photo']}'),
                                fit: BoxFit.cover,
                              ),
                            )
                          : const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/130-1300253_female-user-icon-png-download-user-image-color.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      guides[widget.guideID]['name'] ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      guides[widget.guideID]['email'] ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              guides[widget.guideID]['rating'] != null
                                  ? guides[widget.guideID]['rating'].toString()
                                  : "0",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Text("Rating",
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                            height: 40,
                            width: 1,
                            child: Container(color: Colors.grey)),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Text(
                                guides[widget.guideID]['review'] != null
                                    ? guides[widget.guideID]['review']
                                        .toString()
                                    : "0",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Text(
                              "Review",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          child: Icon(Icons.phone, color: Colors.white),
                          onPressed: () {},
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        MaterialButton(
                          child: Icon(Icons.message, color: Colors.white),
                          onPressed: () {},
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GuideBooking(widget.guideID)),
                            );
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text("Book Now"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
