import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/controllers/user_controller.dart';
import 'package:user_flutter/models/api_response.dart';
import 'package:user_flutter/models/user.dart';
import 'package:user_flutter/views/user/auth/register.dart';
import 'package:user_flutter/views/user/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse apiResponse =
        await login(emailController.text, passwordController.text);
    if (apiResponse.error == null) {
      _saveAndRedirectHome(apiResponse.data as User);
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

  void _saveAndRedirectHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('id', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const UserHome()),
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
                          _loginUser();
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
                                  builder: (context) => const Register()),
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
