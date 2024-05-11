import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../widgets/background.dart';
import '../profile/profile_page.dart';
import 'dashboard/dashboard.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {

  late QRViewController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: (){
                              // Get.to(const ProfilePage(),
                              //   transition: Transition.leftToRightWithFade,
                              //   duration: const Duration(milliseconds: 500),);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            Text(
                              'Senior Creative Designer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 32,
                          child: Image.asset(
                            "assets/icons/splash_logo.png",
                            fit: BoxFit.fitWidth,
                          )),
                    ),
                  ],
                ),

                // const SizedBox(height: 50,),
                const Spacer(),

                const Text(
                  'Scan QR code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 20,),

                const Text(
                  'Place QR code inside the frame to scan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.only(top: 30,bottom: 50),
                  child: Stack(
                    children: [
                      //replace it with a qr scan viewfinder
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 196,
                      //   width: 196,
                      //   color: const Color(0xffd9d9d9),
                      // ),


                      Container(
                          alignment: Alignment.center,
                          height: 196,
                          width: 196,
                        child: QRView(
                          key: GlobalKey(),
                          onQRViewCreated: (QRViewController newController) {
                            controller = newController;
                            controller.scannedDataStream.listen((scanData) {
                              int index = 0;
                              index ++;
                              if (kDebugMode) {
                                print('QR Code Scanned: ${scanData.code}');
                                print('Scanned: $index');
                              }

                              // Handle the scanned data here

                              // Fluttertoast.showToast(
                              //     msg: "${scanData.code}",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     fontSize: 16.0
                              // );


                              controller.pauseCamera();
                              newController.pauseCamera();

                              controller.dispose();
                              newController.dispose();

                              Get.off(
                                const Dashboard(index: 0,),
                                transition: Transition.zoom,
                                duration: const Duration(milliseconds: 500),
                              );


                            });
                          },
                        ),
                      ),



                      Container(
                        alignment: Alignment.center,
                        height: 196,
                        width: 196,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset("assets/images/qr_cross_img.png"),
                        ),

                      ),
                    ],
                  ),
                ),


                Container(
                  width: 266,
                  height: 42,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 59, vertical: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF8DC63F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFF8DC63F)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Scanning Code...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),


                // const SizedBox(height: 20,),
                const Spacer(),

                Center(
                  child: SvgPicture.asset(
                    "assets/images/bottom_image.svg",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
