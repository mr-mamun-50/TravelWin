import 'dart:io';

import 'package:flutter/material.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/tourist_guide_controller.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/tourist_guide.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_flutter/views/welcome.dart';

class EditGuideProfile extends StatefulWidget {
  EditGuideProfile({super.key});

  @override
  State<EditGuideProfile> createState() => _EditGuideProfileState();
}

class _EditGuideProfileState extends State<EditGuideProfile> {
  TouristGuide? guide;
  bool loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  TextEditingController rentPerHourController = TextEditingController();
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
  Future<void> _getGuideDetail() async {
    ApiResponse apiResponse = await getGuideDetail();

    if (apiResponse.error == null) {
      setState(() {
        guide = apiResponse.data as TouristGuide;
        nameController.text = guide!.name ?? '';
        phoneController.text = guide!.phone ?? '';
        addressController.text = guide!.address ?? '';
        nidController.text = guide!.nid ?? '';
        rentPerHourController.text = guide!.rentPerHour ?? '';
        creditCardController.text = guide!.creditCard ?? '';
        loading = false;
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
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
  Future<void> _updateGuide() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      ApiResponse apiResponse = await updateGuideDetail(
          nameController.text,
          phoneController.text,
          addressController.text,
          nidController.text,
          rentPerHourController.text,
          creditCardController.text,
          getStringImage(_imageFile));

      if (apiResponse.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile updated successfully'),
        ));
        setState(() {
          loading = false;
        });
      } else if (apiResponse.error == unauthorized) {
        guideLogout().then((value) => {
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
    _getGuideDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(guide!.name ?? ''),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _getGuideDetail(),
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
                                ? guide!.photo != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            '$imgURL/profile_pictures/${guide!.photo!}'),
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
                            controller: addressController,
                            decoration: inputDecoration('Address'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            controller: nidController,
                            decoration: inputDecoration('NID'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            controller: rentPerHourController,
                            decoration: inputDecoration('Rent per hour (BDT)'),
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
                            setState(() {
                              loading = true;
                              _updateGuide();
                            });
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
