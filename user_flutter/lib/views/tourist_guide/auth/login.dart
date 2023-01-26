import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/tourist_guide_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/tourist_guide.dart';
import 'package:user_flutter/models/user.dart';
import 'package:user_flutter/views/tourist_guide/auth/register.dart';
import 'package:user_flutter/views/tourist_guide/home.dart';
import 'package:user_flutter/views/user/auth/register.dart';

class GuideLogin extends StatefulWidget {
  const GuideLogin({super.key});

  @override
  State<GuideLogin> createState() => _GuideLoginState();
}

class _GuideLoginState extends State<GuideLogin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void _loginGuide() async {
    ApiResponse apiResponse =
        await guideLogin(emailController.text, passwordController.text);
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
      body: Container(
        decoration: const BoxDecoration(color: Colors.blue),
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
                const Text('Tourist Guide Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                Container(
                  height: 310,
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
                              _loginGuide();
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
                                      builder: (context) =>
                                          const GuideRegister()),
                                  (route) => false);
                            },
                            child: const Text('Register'),
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
    );
  }
}
