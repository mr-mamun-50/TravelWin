import 'package:flutter/material.dart';
import 'package:user_flutter/constant.dart';

class UserDashBoard extends StatefulWidget {
  UserDashBoard({Key? key}) : super(key: key);

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadingText("Popular Destinations"),
        SizedBox(
          height: 350,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              PostCard(
                  "Bandarban, Bangladesh",
                  "Tinap Saitar",
                  "https://www.daily-sun.com/assets/news_images/2020/01/29/Bandarban.jpg",
                  "4.5",
                  2,
                  27.5,
                  "View Details"),
              PostCard(
                  "Chittagong, Bangladesh",
                  "Saint Martin",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAzHeZ9YsdC0EKMr_KlJN9Rt9JeuPOb1uU0g&usqp=CAU",
                  "4.5",
                  5,
                  32.8,
                  "View Details"),
              PostCard(
                  "Sylhet, Bangladesh",
                  "Sri Mongol",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGS0MOKkGD9mThOX2QfMefRRjW3xwIQ7PUsA&usqp=CAU",
                  "4.5",
                  1,
                  5.7,
                  "View Details"),
            ],
          ),
        ),
        HeadingText("Traveller's Choice"),
      ],
    );
  }
}
