import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/view/login/complete_profile_view.dart';
import 'package:fitness/view/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:fitness/view/login/signup_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginView extends StatefulWidget {
  final Map<String, String>? userData; // Accepts signup data
  const LoginView({Key? key, this.userData}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

final String ip = dotenv.env['IP_CONFIG'] ?? 'http://default-url:8000';
void _handleLogin(BuildContext context, String email, String password) async {
  const String loginUrl =
      "http://192.168.87.188:8000/user/login/"; // Update with actual URL
  // 192.168.81.188 (hotspot me)

  // 192.168.5.43:8000 (wifi)
  try {
    final response = await http.post(
      Uri.parse(loginUrl),
      body: {
        'UserEmail': email,
        'UserPassword': password,
      },
    );
    print(response.body); // To check the response

    // Check if the response status is 200
    if (response.statusCode == 200) {
      // Parse the JSON response into a Map
      final Map<String, dynamic> data = json.decode(response.body);

      // Now handle the data correctly
      if (data != null && data['success'] == true) {
        // Extract user data properly from the 'data' field
        final userData = data['data'];

        print("userData from login func: $userData ");
        // Navigate to the next screen on successful login
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainTabView(userData: {
              'firstname': userData['UserFirstName'],
              'lastname': userData['UserLastName'],
              'email': userData['UserEmail'],
              'gender': userData['UserGender'],
              'weight': userData['UserWeight'.toString()],
              'height': userData['UserHeight'.toString()],
            }), // Adjust as needed
          ),
        );

        print("passed user data from login: $userData");

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Welcome, ${userData['UserFirstName']} ${userData['UserLastName']}"),
          ),
        );
      } else {
        // If 'success' is false, handle the error
        final error = data['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(error != null ? data['error'] : 'Invalid credentials'),
          ),
        );
      }
    } else {
      // Handle other status codes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server Error: ${response.statusCode}')),
      );
    }
  } catch (e) {
    print("Error: ${e.toString()}"); // Log the error message
    // Handle network errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occured. Check logs')),
    );
  }
}

class _LoginViewState extends State<LoginView> {
  bool isCheck = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      color: TColor.gray,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.5,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Email",
                  icon: "assets/img/email.png",
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Password",
                  icon: "assets/img/lock.png",
                  obscureText: true,
                  controller: _passwordController,
                  rightIcon: TextButton(
                      onPressed: () {},
                      child: Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            "assets/img/show_password.png",
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            color: TColor.gray,
                          ))),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot your password?",
                      style: TextStyle(
                          color: TColor.gray,
                          fontSize: 10,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                const Spacer(),
                RoundButton(
                    title: "Login",
                    onPressed: () {
                      final email = _emailController
                          .text; // Retrieve email from RoundTextField
                      final password = _passwordController
                          .text; // Retrieve password from RoundTextField
                      print("Email: $email, Password: $password");
                      _handleLogin(context, email, password);
                    }),
                SizedBox(
                  height: media.width * 0.04,
                ),
                // Row(
                //   // crossAxisAlignment: CrossAxisAlignment.,
                //   children: [
                //     Expanded(
                //         child: Container(
                //       height: 1,
                //       color: TColor.gray.withOpacity(0.5),
                //     )),
                //     Text(
                //       "  Or  ",
                //       style: TextStyle(color: TColor.black, fontSize: 12),
                //     ),
                //     Expanded(
                //         child: Container(
                //       height: 1,
                //       color: TColor.gray.withOpacity(0.5),
                //     )),
                //   ],
                // ),
                // SizedBox(
                //   height: media.width * 0.04,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         width: 50,
                //         height: 50,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: TColor.white,
                //           border: Border.all(
                //             width: 1,
                //             color: TColor.gray.withOpacity(0.4),
                //           ),
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Image.asset(
                //           "assets/img/google.png",
                //           width: 20,
                //           height: 20,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: media.width * 0.04,
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         width: 50,
                //         height: 50,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: TColor.white,
                //           border: Border.all(
                //             width: 1,
                //             color: TColor.gray.withOpacity(0.4),
                //           ),
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Image.asset(
                //           "assets/img/facebook.png",
                //           width: 20,
                //           height: 20,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpView()));
                        },
                        child: (Text(
                          ("Don't have an account yet? Register!"),
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
