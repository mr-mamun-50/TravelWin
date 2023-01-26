import 'package:flutter/material.dart';

class UserFavourites extends StatefulWidget {
  const UserFavourites({super.key});

  @override
  State<UserFavourites> createState() => _UserFavouritesState();
}

class _UserFavouritesState extends State<UserFavourites> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("User Favourites"),
        ],
      ),
    );
  }
}
