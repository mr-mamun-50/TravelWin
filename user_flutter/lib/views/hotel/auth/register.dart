import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/hotel_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/hotel.dart';
import 'package:user_flutter/views/hotel/auth/login.dart';
import 'package:user_flutter/views/hotel/home.dart';
import 'package:user_flutter/views/tourist_guide/auth/login.dart';

class HotelRegister extends StatefulWidget {
  const HotelRegister({super.key});

  @override
  State<HotelRegister> createState() => _HotelRegisterState();
}

class _HotelRegisterState extends State<HotelRegister> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void _registerHotel() async {
    ApiResponse apiResponse = await hotelRegister(nameController.text,
        phoneController.text, emailController.text, passwordController.text);
    if (apiResponse.error == null) {
      _saveAndRedirectHotelHome(apiResponse.data as Hotel);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(apiResponse.error!),
        ),
      );
    }
  }

  void _saveAndRedirectHotelHome(Hotel hotel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('hotelToken', hotel.hotelToken ?? '');
    await pref.setInt('id', hotel.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HotelHome()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: Form(
          key: formKey,
          child: Center(
            child: Container(
              height: 570,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                    )
                  ]),
              child: ListView(
                children: [
                  const Image(
                      image: AssetImage('images/logos/logo.png'), height: 40),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                        controller: nameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Name is required' : null,
                        decoration: inputDecoration('name')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: phoneController,
                      validator: (value) =>
                          value!.isEmpty ? 'Phone is required' : null,
                      keyboardType: TextInputType.phone,
                      decoration: inputDecoration('Phone'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'Email is required' : null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputDecoration('Email'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) =>
                          value!.isEmpty ? 'Password is required' : null,
                      obscureText: true,
                      decoration: inputDecoration('Password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      validator: (value) => value!.isEmpty
                          ? 'Re-enter the password'
                          : value != passwordController.text
                              ? 'Password does not match'
                              : null,
                      obscureText: true,
                      decoration: inputDecoration('Confirm Password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: submitBtn('REGISTER', loading, () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          _registerHotel();
                        });
                      }
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HotelLogin()),
                              (route) => false);
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
