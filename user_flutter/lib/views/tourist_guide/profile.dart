import 'package:flutter/material.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/tourist_guide_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/tourist_guide.dart';
import 'package:user_flutter/views/tourist_guide/edit_profile.dart';
import 'package:user_flutter/views/tourist_guide/edit_service.dart';
import 'package:user_flutter/views/welcome.dart';

class GuideProfile extends StatefulWidget {
  const GuideProfile({super.key});

  @override
  State<GuideProfile> createState() => _GuideProfileState();
}

class _GuideProfileState extends State<GuideProfile> {
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
    return RefreshIndicator(
      onRefresh: () => _getGuideDetail(),
      child: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 200,
                width: 200,
                decoration: guide?.photo != null
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              '$imgURL/profile_pictures/${guide!.photo!}'),
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
                guide?.name ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                guide?.email ?? "",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              submitBtn("Edit Profile", false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditGuideProfile()),
                );
              }),

              // More Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    HeadingText("Service area"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(guide?.serviceArea ?? ""),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditGuideService()),
                            );
                          },
                          minWidth: 0,
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    HeadingText("More Details"),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("Phone"),
                      subtitle: Text(guide?.phone ?? ""),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text("Address"),
                      subtitle: Text(guide?.address ?? ""),
                    ),
                    ListTile(
                      leading: Icon(Icons.money_rounded),
                      title: Text("Rent Per Hour"),
                      subtitle: Text(guide?.rentPerHour ?? ""),
                    ),
                    const ListTile(
                      leading: Icon(Icons.date_range),
                      title: Text("Date of Birth"),
                      subtitle: Text("01-01-2000"),
                    ),
                    ListTile(
                      leading: Icon(Icons.card_membership),
                      title: Text("NID Number"),
                      subtitle: Text(guide?.nid ?? ""),
                    ),
                    ListTile(
                      leading: Icon(Icons.credit_card),
                      title: Text("Credit Card"),
                      subtitle: Text(guide?.creditCard ?? ""),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
