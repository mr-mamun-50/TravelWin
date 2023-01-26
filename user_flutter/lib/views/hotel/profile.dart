import 'package:flutter/material.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/hotel_controller.dart';
import 'package:user_flutter/controllers/tourist_guide_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/hotel.dart';
import 'package:user_flutter/views/hotel/edit_address.dart';
import 'package:user_flutter/views/hotel/edit_profile.dart';
import 'package:user_flutter/views/welcome.dart';

class HotelProfile extends StatefulWidget {
  const HotelProfile({super.key});

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  Hotel? hotel;
  bool loading = true;

  //__get user__
  Future<void> _getHotelDetail() async {
    ApiResponse apiResponse = await getHotelDetail();

    if (apiResponse.error == null) {
      setState(() {
        hotel = apiResponse.data as Hotel;

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
    _getHotelDetail();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _getHotelDetail(),
      child: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 200,
                width: 200,
                decoration: hotel?.logo != null
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              '$imgURL/profile_pictures/${hotel!.logo!}'),
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
                hotel?.name ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                hotel?.email ?? "",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              submitBtn("Edit Profile", false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditHotelProfile()),
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
                            child: Text(hotel?.address ?? "No address"),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditHotelAddress()),
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
                      subtitle: Text(hotel?.phone ?? ""),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text("Address"),
                      subtitle: Text(hotel?.address ?? ""),
                    ),
                    ListTile(
                      leading: Icon(Icons.credit_card),
                      title: Text("Credit Card"),
                      subtitle: Text(hotel?.creditCard ?? ""),
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
