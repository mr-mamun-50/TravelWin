import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/views/welcome.dart';

class GuideBooking extends StatefulWidget {
  final int guideID;
  GuideBooking(this.guideID, {super.key});

  @override
  State<GuideBooking> createState() => _GuideBookingState();
}

class _GuideBookingState extends State<GuideBooking> {
  String _date = 'select date';
  String _time = 'select time';

  bool loading = false;

  //store booking
  void _storeBooking() async {
    print("Helooooooooooo");
    print(widget.guideID);
    ApiResponse apiResponse = await storeBooking(_date, _time, widget.guideID);

    if (apiResponse.error == null) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(apiResponse.data!.toString()),
        ));
        loading = false;
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Welcome()),
                (route) => false)
          });
      loading = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(apiResponse.error!),
      ));
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Booking'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              onPressed: () {
                DatePicker.showDatePicker(context, showTitleActions: true,
                    onConfirm: (date) {
                  _date = '${date.year}-${date.month}-${date.day}';
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              color: Colors.grey[300],
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _date.toString() ?? 'Select date',
                    style: TextStyle(color: Colors.black87),
                  ),
                  Icon(Icons.date_range)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              onPressed: () {
                DatePicker.showTime12hPicker(context, showTitleActions: true,
                    onConfirm: (time) {
                  _time = '${time.hour}:${time.minute}';
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              color: Colors.grey[300],
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _time.toString() ?? 'Select time',
                    style: TextStyle(color: Colors.black87),
                  ),
                  Icon(Icons.lock_clock)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: submitBtn('Send for booking', loading, () {
              setState(() {
                loading = true;
                _storeBooking();
              });
            }),
          )
        ],
      ),
    );
  }
}
