import 'package:flutter/material.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/views/user/edit_profile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://i.pravatar.cc/300"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Mamunur Rashid Mamun",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "mrmamun20162017@gmail.com",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            submitBtn("Edit Profile", false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserProfile(),
                ),
              );
            }),

            // More Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  HeadingText("More Details"),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("Phone"),
                    subtitle: Text("+880 1711 111 111"),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text("Address"),
                    subtitle: Text("Dhaka, Bangladesh"),
                  ),
                  ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text("Date of Birth"),
                    subtitle: Text("01-01-2000"),
                  ),
                  ListTile(
                    leading: Icon(Icons.card_membership),
                    title: Text("NID Number"),
                    subtitle: Text("1234567890"),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text("Credit Card"),
                    subtitle: Text("1234 5678 9012 3456"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ],
    );
  }
}
