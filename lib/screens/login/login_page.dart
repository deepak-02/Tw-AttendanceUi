import 'package:attendance/screens/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_number_suggestion_3/models/phone_number_suggestion_model.dart';
import 'package:phone_number_suggestion_3/phone_number_suggestion_3.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryCode = 'IN';
  String phoneNumber = '';
  TextEditingController phoneController = TextEditingController();

  final _phoneNumberSuggestion_3Plugin = PhoneNumberSuggestion_3();

  @override
  void initState() {
    super.initState();
    getNumber(context: context);
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
            Column(
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
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    onChanged: (value) {},
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
                        Get.offAll(
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
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void getNumber({required BuildContext context}) async {
    PhoneNumber intlPhoneFieldData = await _phoneNumberSuggestion_3Plugin
        .getPhoneNumber(); // Use the aliased import
    getMessage(intlPhoneFieldData: intlPhoneFieldData);
  }

  String getMessage({required PhoneNumber intlPhoneFieldData}) {
    // Adjust the parameter name accordingly
    switch (intlPhoneFieldData) {
      // Use the aliased import
      case Success():
        phoneController.text = intlPhoneFieldData.phoneNumber;
        return intlPhoneFieldData
            .phoneNumber; // Adjust the property name accordingly
      case Failure():
        return intlPhoneFieldData
            .errorMessage; // Adjust the property name accordingly
      case ClosedByUser():
        return 'closed by user';
      case NoneOfTheSelected():
        return 'error occurred';
    }
  }
}
