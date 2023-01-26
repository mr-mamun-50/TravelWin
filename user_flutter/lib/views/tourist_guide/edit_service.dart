import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/tourist_guide_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/views/welcome.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class EditGuideService extends StatefulWidget {
  const EditGuideService({super.key});

  @override
  State<EditGuideService> createState() => _EditGuideServiceState();
}

class _EditGuideServiceState extends State<EditGuideService> {
  TextEditingController searchAreaController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;
  var uuid = Uuid();
  String sessionToken = "";

  List<dynamic> placeSearchList = [];

  //__Place search__
  void onChange() {
    if (searchAreaController.text.length == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestion(searchAreaController.text);
  }

  Future<void> getSuggestion(String input) async {
    String apiKey = "AIzaSyBCcDhyZ9Fqi1X3HxUbcYqoVf2jBU8Jfek";
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        "$baseUrl?input=$input&key=$apiKey&sessiontoken=$sessionToken";

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        placeSearchList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

//__Update latitude and longitude__
  Future<void> _updateGuideLatLng() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      List<Location> locations =
          await locationFromAddress(searchAreaController.text.toString());

      String latitude = locations[0].latitude.toString();
      String longitude = locations[0].longitude.toString();

      ApiResponse apiResponse = await updateGuideLatLng(
          searchAreaController.text.toString(), latitude, longitude);

      if (apiResponse.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile updated successfully'),
        ));
        setState(() {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchAreaController.addListener(() {
      onChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Service"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: searchAreaController,
                decoration: const InputDecoration(
                    hintText: "Search Area",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            placeSearchList.length == 0
                ? const SizedBox()
                : Expanded(
                    child: ListView.builder(
                      itemCount: placeSearchList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(placeSearchList[index]['description']),
                          onTap: () async {
                            setState(() {
                              searchAreaController = TextEditingController(
                                  text: placeSearchList[index]['description']);

                              placeSearchList = [];
                            });
                          },
                        );
                      },
                    ),
                  ),
            Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: submitBtn('Update', loading, () {
                setState(() {
                  loading = true;
                  _updateGuideLatLng();
                });
              }),
            )
          ],
        ),
      ),
    );
  }
}
