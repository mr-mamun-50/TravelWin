import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/driver_controller.dart';
import 'package:user_flutter/controllers/hotel_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/driver.dart';
import 'package:user_flutter/models/hotel.dart';
import 'package:user_flutter/views/driver/auth/register.dart';
import 'package:user_flutter/views/driver/home.dart';
import 'package:user_flutter/views/hotel/auth/register.dart';
import 'package:user_flutter/views/hotel/home.dart';

class DriverLogin extends StatefulWidget {
  const DriverLogin({super.key});

  @override
  State<DriverLogin> createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void _loginDriver() async {
    ApiResponse apiResponse =
        await driverLogin(emailController.text, passwordController.text);
    if (apiResponse.error == null) {
      _saveAndRedirectDriverHome(apiResponse.data as Driver);
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

  void _saveAndRedirectDriverHome(Driver driver) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('driverToken', driver.driverToken ?? '');
    await pref.setInt('id', driver.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DriverHome()),
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
              height: 380,
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
                      image: AssetImage('images/logos/logo.png'), height: 50),
                  const SizedBox(height: 20),
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
                      validator: (value) => value!.length < 8
                          ? 'Password at least 8 character'
                          : null,
                      obscureText: true,
                      decoration: inputDecoration('Password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: submitBtn('LOGIN', loading, () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          _loginDriver();
                        });
                      }
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const DriverRegister()),
                              (route) => false);
                        },
                        child: const Text('Register'),
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
