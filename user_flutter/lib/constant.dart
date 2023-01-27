import 'package:flutter/material.dart';

//__URL's__
const baseURL = 'http://192.168.137.71:8000/api';
const imgURL = 'http://192.168.137.71:8000/images';

//__User URL's__
const userLoginURL = '$baseURL/user/login';
const userRegisterURL = '$baseURL/user/register';
const userLogOutURL = '$baseURL/user/logout';
const userURL = '$baseURL/user';
const allTouristGuidesURL = '$baseURL/user/all_tourist_guides';

//__Tourist Guide URL's__
const guideLoginURL = '$baseURL/tourist_guide/login';
const guideRegisterURL = '$baseURL/tourist_guide/register';
const guideLogOutURL = '$baseURL/tourist_guide/logout';
const guideURL = '$baseURL/tourist_guide/user';
const guideUpdateURL = '$baseURL/tourist_guide/update';
const guideUpdateServiceAreaURL = '$baseURL/tourist_guide/update/service_area';

//__Hotel URL's__
const hotelLoginURL = '$baseURL/hotel/login';
const hotelRegisterURL = '$baseURL/hotel/register';
const hotelLogOutURL = '$baseURL/hotel/logout';
const hotelURL = '$baseURL/hotel/user';
const hotelUpdateURL = '$baseURL/hotel/update';
const hotelUpdateAddressURL = '$baseURL/hotel/update/address';

//__Driver URL's__
const driverLoginURL = '$baseURL/driver/login';
const driverRegisterURL = '$baseURL/driver/register';
const driverLogOutURL = '$baseURL/driver/logout';
const driverURL = '$baseURL/driver/user';

//__Error Messages__
const serverError = 'Server Error';
const noInternet = 'No Internet Connection';
const unauthorized = 'Unauthorized';
const somethingWrong = 'Something went wrong, try again!';

//__input_decoration__
InputDecoration inputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
    contentPadding: const EdgeInsets.all(15.0),
  );
}

//__Button__
ElevatedButton submitBtn(String label, bool loading, Function onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    child: loading
        ? const SizedBox(
            height: 15,
            width: 15,
            child:
                CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
          )
        : Text(label),
    onPressed: () => onPressed(),
  );
}

//__Likes & comments button__
Expanded likesCommentsBtn(
    int? value, IconData icon, Color color, Function onPressed) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 5),
              value != null ? Text('(${value.toString()})') : const SizedBox(),
            ],
          ),
        ),
      ),
    ),
  );
}

//__Heading text__
Container HeadingText(String text) {
  return Container(
    height: 50,
    padding: EdgeInsets.all(10),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

//__Post Card__
Padding PostCard(String location, String title, String photo, String rating,
    int review, double distance, String button) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                  image: NetworkImage(photo), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 14, color: Colors.black45),
              const SizedBox(width: 5),
              Text(
                location,
                style: const TextStyle(color: Colors.black45, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
                backgroundColor: Colors.white,
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.call_split_rounded,
                          size: 14, color: Colors.black45),
                      const SizedBox(width: 5),
                      Text(
                        '$distance km',
                        style: const TextStyle(
                            color: Colors.black45, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 14, color: Colors.orangeAccent),
                      const SizedBox(width: 5),
                      Text(
                        rating,
                        style: const TextStyle(
                            color: Colors.black45, fontSize: 16),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '($review)',
                        style: const TextStyle(
                            color: Colors.black45, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              MaterialButton(
                minWidth: 20,
                onPressed: () {},
                color: Colors.black26,
                shape: const CircleBorder(),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

//__Welcome Btn__

Container WelcomeBtn(String label, Function onPressed) {
  return Container(
    height: 60,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
            )
          ],
        ),
      ),
    ),
  );
}
