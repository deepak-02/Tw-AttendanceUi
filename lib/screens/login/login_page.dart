import 'package:attendance/screens/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryCode = 'IN';
  String phoneNumber = '';
  TextEditingController phoneController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xff21206a),
              child: Center(
                child: SizedBox(
                    width: 80,
                    child: Image.asset(
                      "assets/icons/splash_logo.png",
                      fit: BoxFit.fitWidth,
                    )),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Text(
                    "Techwyse: Mark your seats ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      indent: 20.0,
                      endIndent: 10.0,
                      thickness: 1.5,
                    )),
                    Text(
                      "Login with us",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D1E1F)),
                    ),
                    Expanded(
                        child: Divider(
                      indent: 20.0,
                      endIndent: 10.0,
                      thickness: 1.5,
                    )),
                  ]),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntlPhoneField(
                    disableLengthCheck: true,
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      setState(() {
                        phoneNumber = phone.completeNumber;
                      });
                      if (kDebugMode) {
                        print(phone.completeNumber);
                      }
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: const Color(0xff21206a),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        minimumSize: const Size(100, 40),
                      ),
                      onPressed: () {
                        if (kDebugMode) {
                          print(phoneController.text);
                          print(phoneNumber);
                        }
                        Get.to(
                          const Home(),
                          transition: Transition.circularReveal,
                          duration: const Duration(milliseconds: 800),
                        );
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// //sms_autofill
// @override
// void initState() {
//   super.initState();
//   Future<void>.delayed(const Duration(milliseconds: 300), _tryPasteCurrentPhone);
// }
//
// Future _tryPasteCurrentPhone() async {
//   if (!mounted) return;
//   try {
//     final autoFill = SmsAutoFill();
//     final phone = await autoFill.hint;
//     if (phone == null) return;
//     if (!mounted) return;
//     _textController.value = phone;
//   } on PlatformException catch (e) {
//     print('Failed to get mobile number because of: ${e.message}');
//   }
// }