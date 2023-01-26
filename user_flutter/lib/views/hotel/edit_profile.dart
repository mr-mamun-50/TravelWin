import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/hotel_controller.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/hotel.dart';
import 'package:user_flutter/views/welcome.dart';

class EditHotelProfile extends StatefulWidget {
  const EditHotelProfile({super.key});

  @override
  State<EditHotelProfile> createState() => _EditHotelProfileState();
}

class _EditHotelProfileState extends State<EditHotelProfile> {
  Hotel? hotel;
  bool loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numberOfRoomsController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController creditCardController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  //__get user__
  Future<void> _getHotelDetail() async {
    ApiResponse apiResponse = await getHotelDetail();

    if (apiResponse.error == null) {
      setState(() {
        hotel = apiResponse.data as Hotel;
        nameController.text = hotel!.name ?? '';
        phoneController.text = hotel!.phone ?? '';
        numberOfRoomsController.text = hotel?.numberOfRooms.toString() ?? '';
        creditCardController.text = hotel!.creditCard ?? '';

        loading = false;
      });
    } else if (apiResponse.error == unauthorized) {
      hotelLogout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Welcome()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(apiResponse.error!),
      ));
      setState(() {
        loading = false;
      });
    }
  }

  //__update user__
  Future<void> _updateHotel() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      ApiResponse apiResponse = await updateHotelDetail(
          nameController.text,
          phoneController.text,
          int.parse(numberOfRoomsController.text),
          creditCardController.text,
          getStringImage(_imageFile));

      if (apiResponse.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Profile Updated'),
        ));
        setState(() {
          loading = false;
        });
      } else if (apiResponse.error == unauthorized) {
        hotelLogout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Welcome()),
                  (route) => false)
            });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(apiResponse.error!),
        ));
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _getHotelDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel!.name ?? ''),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _getHotelDetail(),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: _imageFile == null
                                ? hotel!.logo != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            '$imgURL/profile_pictures/${hotel!.logo!}'),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: NetworkImage(
                                            'https://www.pngitem.com/pimgs/m/130-1300253_female-user-icon-png-download-user-image-color.png'),
                                        fit: BoxFit.cover,
                                      )
                                : DecorationImage(
                                    image: FileImage(_imageFile ?? File('')),
                                    fit: BoxFit.cover,
                                  ),
                            color: Colors.black12,
                          )),
                      onTap: () {
                        getImage();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            controller: nameController,
                            decoration: inputDecoration('Name'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            controller: phoneController,
                            decoration: inputDecoration('Phone'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: numberOfRoomsController,
                            decoration: inputDecoration('Number of Rooms'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            controller: creditCardController,
                            decoration: inputDecoration('Credit Card Number'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        submitBtn("Update Profile", loading, () {
                          if (formKey.currentState!.validate()) {
                            // setState(() {
                            //   loading = true;
                            // });
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
