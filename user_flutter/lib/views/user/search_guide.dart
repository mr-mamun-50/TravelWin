import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:user_flutter/models/nearby_searches.dart';
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
      //   loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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

          //__show nearby places__
          if (nearbyPlacesResponse.results != null)
            ListView.builder(
              shrinkWrap: true,
              itemCount: nearbyPlacesResponse.results!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      nearbyPlacesResponse.results![index].name.toString()),
                );
              },
            ),
        ],
      ),
    );
  }
}
