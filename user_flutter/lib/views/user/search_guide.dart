import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uuid/uuid.dart';

class SearchGuide extends StatefulWidget {
  SearchGuide({Key? key}) : super(key: key);

  @override
  State<SearchGuide> createState() => _SearchGuideState();
}

class _SearchGuideState extends State<SearchGuide> {
  TextEditingController _searchGuideController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;
  var uuid = Uuid();
  String sessionToken = "";

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
                          });
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
