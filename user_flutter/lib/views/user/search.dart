import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class UserSearch extends StatefulWidget {
  UserSearch({Key? key}) : super(key: key);

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  TextEditingController _searchController = TextEditingController();
  var uuid = Uuid();
  String sessionToken = "";

  List<dynamic> placeSearchList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _searchController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_searchController.text.length == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }

    getSuggestion(_searchController.text);
  }

  void getSuggestion(String input) async {
    String apiKey = "AIzaSyBCcDhyZ9Fqi1X3HxUbcYqoVf2jBU8Jfek";
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        "$baseUrl?input=$input&key=$apiKey&sessiontoken=$sessionToken";

    var response = await http.get(Uri.parse(request));

    var data = response.body.toString();
    print(data);

    if (response.statusCode == 200) {
      setState(() {
        placeSearchList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: placeSearchList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(placeSearchList[index]['description']),
                onTap: () async {
                  List<Location> locations = await locationFromAddress(
                      placeSearchList[index]['description']);

                  print(locations.last.latitude);
                  print(locations.last.longitude);
                },
              );
            },
          ),
        )
      ],
    );
  }
}
