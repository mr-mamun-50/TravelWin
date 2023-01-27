import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/nearby_searches.dart';
import 'package:user_flutter/models/tourist_guide.dart';
import 'package:user_flutter/views/welcome.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class SearchGuide extends StatefulWidget {
  SearchGuide({Key? key}) : super(key: key);

  @override
  State<SearchGuide> createState() => _SearchGuideState();
}

class _SearchGuideState extends State<SearchGuide> {
  TextEditingController _searchGuideController = TextEditingController();

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String apiKey = "AIzaSyBCcDhyZ9Fqi1X3HxUbcYqoVf2jBU8Jfek";
  bool loading = false;
  var uuid = Uuid();
  String sessionToken = "";

  String radius = "50";
  String latitude = "";
  String longitude = "";
  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();

  List<dynamic> placeSearchList = [];
  List<dynamic> allTouristGuideList = [];
  List<dynamic> nearbyGuideID = [];
  List<dynamic> nearbyGuideList = [];
  List<dynamic> FinalNearbyGuideList = [];

  //__Place search__
  void onChange() {
    if (_searchGuideController.text.length == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestion(_searchGuideController.text);
  }

  //__get place suggestion__
  Future<void> getSuggestion(String input) async {
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

  //__get all guide__
  Future<void> getAllGuide() async {
    ApiResponse apiResponse = await getAllTouristGuide();
    if (apiResponse.error == null) {
      setState(() {
        allTouristGuideList = apiResponse.data as List<dynamic>;

        loading = false;

        print(allTouristGuideList.first['name']);
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Welcome()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${apiResponse.error}'),
      ));
      setState(() {
        loading = !loading;
      });
    }
  }

  //__get nearby places__
  Future<void> _comphareLatLng() async {
    setState(() {
      loading = true;
    });
    List<Location> locations =
        await locationFromAddress(_searchGuideController.text.toString());

    latitude = locations[0].latitude.toString();
    longitude = locations[0].longitude.toString();
    //__get nearby places__
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&key=$apiKey");

    var response = await http.post(url);
    nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));
    setState(() {
      loading = false;
    });

    for (int i = 0; i < nearbyPlacesResponse.results!.length; i++) {
      for (int j = 0; j < allTouristGuideList.length; j++) {
        if (nearbyPlacesResponse.results![i].geometry!.location!.lat!
                .toDouble()
                .round() ==
            double.parse(allTouristGuideList[j]['service_area_lat']).round()) {
          nearbyGuideList.add(allTouristGuideList[j]);
        }
      }
    }
    FinalNearbyGuideList = nearbyGuideList.toSet().toList();
  }

  @override
  void initState() {
    getAllGuide();
    super.initState();

    _searchGuideController.addListener(() {
      onChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: _searchGuideController,
          decoration: const InputDecoration(
            hintText: "Search guide by place...",
            contentPadding: EdgeInsets.only(top: 15),
            suffixIcon: Icon(Icons.search, color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
      ),
      body: Column(
        children: [
          placeSearchList.isEmpty
              ? const SizedBox()
              : Expanded(
                  child: ListView.builder(
                    itemCount: placeSearchList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(placeSearchList[index]['description']),
                        onTap: () async {
                          setState(() {
                            _searchGuideController = TextEditingController(
                                text: placeSearchList[index]['description']);

                            placeSearchList = [];
                            _comphareLatLng();
                          });
                        },
                      );
                    },
                  ),
                ),

          //__show nearby guides__
          FinalNearbyGuideList.isEmpty
              ? const SizedBox()
              : Expanded(
                  child: ListView.builder(
                    itemCount: FinalNearbyGuideList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FinalNearbyGuideList[index]
                                      ['photo'] ==
                                  null
                              ? const NetworkImage(
                                  'https://www.pngitem.com/pimgs/m/130-1300253_female-user-icon-png-download-user-image-color.png')
                              : NetworkImage(
                                  '$imgURL/profile_pictures/${FinalNearbyGuideList[index]['photo']}'),
                        ),
                        title: Text(FinalNearbyGuideList[index]['name']),
                        subtitle: FinalNearbyGuideList[index]
                                    ['rent_per_hour'] !=
                                null
                            ? Text(
                                '${FinalNearbyGuideList[index]['rent_per_hour']} BDT/Hour',
                                style: TextStyle(color: Colors.red))
                            : const Text('0'),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
