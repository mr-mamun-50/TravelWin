import 'package:flutter/material.dart';

class BookingsOfGuide extends StatefulWidget {
  const BookingsOfGuide({super.key});

  @override
  State<BookingsOfGuide> createState() => _BookingsOfGuideState();
}

class _BookingsOfGuideState extends State<BookingsOfGuide> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            //booking card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Booking ID: 1'),
                  subtitle: Text('Date: 2021-09-01'),
                  trailing: Text('Time: 10:00'),
                ),
              ),
            ),
            //booking card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Booking ID: 2'),
                  subtitle: Text('Date: 2021-09-02'),
                  trailing: Text('Time: 10:00'),
                ),
              ),
            ),
            //booking card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Booking ID: 3'),
                  subtitle: Text('Date: 2021-09-03'),
                  trailing: Text('Time: 10:00'),
                ),
              ),
            ),
            //booking card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Booking ID: 4'),
                  subtitle: Text('Date: 2021-09-04'),
                  trailing: Text('Time: 10:00'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
