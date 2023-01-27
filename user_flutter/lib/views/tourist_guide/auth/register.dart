import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/tourist_guide_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/tourist_guide.dart';
import 'package:user_flutter/views/tourist_guide/auth/login.dart';
import 'package:user_flutter/views/tourist_guide/home.dart';

class GuideRegister extends StatefulWidget {
  const GuideRegister({super.key});

  @override
  State<GuideRegister> createState() => _GuideRegisterState();
}

class _GuideRegisterState extends State<GuideRegister> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void _registerGuide() async {
    ApiResponse apiResponse = await guideRegister(nameController.text,
        phoneController.text, emailController.text, passwordController.text);
    if (apiResponse.error == null) {
      _saveAndRedirectGuideHome(apiResponse.data as TouristGuide);
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

  void _saveAndRedirectGuideHome(TouristGuide guide) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('guideToken', guide.guideToken ?? '');
    await pref.setInt('id', guide.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const TouristGuideHome()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.blue),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                      image: AssetImage('images/logos/logo_white.png'),
                      height: 70),
                  const SizedBox(height: 20),
                  const Text('Tourist Guide Regisdter',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  Container(
                    height: 520,
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
                                _registerGuide();
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
                                        builder: (context) =>
                                            const GuideLogin()),
                                    (route) => false);
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
                    ),
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
