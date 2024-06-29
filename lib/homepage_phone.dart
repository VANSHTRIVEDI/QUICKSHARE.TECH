import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickshare/developers.dart';
import 'package:quickshare/recieve_page.dart';
import 'package:quickshare/send_page.dart';

class HomePagePhone extends StatefulWidget {
  const HomePagePhone({super.key});

  @override
  State<HomePagePhone> createState() => _HomePagePhoneState();
}

class _HomePagePhoneState extends State<HomePagePhone> {
  var firestore = FirebaseFirestore.instance.collection('users');
  String generatedotp = "";
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double x = screenWidth * 0.1;
    if (screenWidth < 250 || screenHeight < 400) {
      return const Scaffold(
        backgroundColor: Color.fromARGB(231, 33, 82, 96),
      );
    } else {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(220, 238, 241, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: const Color.fromARGB(255, 237, 237, 237),
          elevation: 3,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 53, 125, 145),
                        borderRadius: BorderRadius.circular(100)),
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.asset(
                      'images/send.png', // Replace 'your_icon.png' with your actual icon asset path
                      width: 35, // Adjust width as needed
                      height:
                          35, // Adjust height as needed// Adjust color as needed
                    ),
                  ),
                  const SizedBox(
                    width: 8, // Adjust spacing between icon and text as needed
                  ),
                  Text(
                    "Quick",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Color.fromARGB(255, 0, 0, 0),
                      // color: Colors.white,
                    )),
                  ),
                  Text(
                    "Share",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Color.fromARGB(255, 53, 125, 145),
                    )),
                  ),
                ],
              ),
              if (screenWidth >= 450)
                Flexible(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Developers(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 210, 210, 210),
                          borderRadius: BorderRadius.circular(100)),
                      child: const Text(
                        "Developers",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              if (screenWidth < 450)
                Flexible(
                  child: IconButton(
                      disabledColor: Colors.black54,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Developers(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 141, 141, 141),
                      )),
                ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      "QuickShare",
                      textAlign: TextAlign.center,
                      // style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: (screenHeight < 700) ? 32 : 36,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        // color: Colors.white,
                      )),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Connect Effortlessly \nShare Anonymously",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: (screenHeight < 700) ? 20 : 30,
                        color: const Color.fromARGB(255, 41, 41, 41),
                        // color: Colors.white,
                      )),
                    ),
                  ),
                ],
              ),
              if (screenHeight > 580)
                Center(
                  child: Image.asset(
                    "images/title_image.png",
                    height: (screenHeight < 700) ? 300 : 350,
                    width: (screenHeight < 700) ? 300 : 350,
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                          (screenWidth < 1300) ? 30 : screenWidth),
                      onTap: () async {
                        _showLoadingDialog(context);
                        await otpgenerator();
                        await firestore
                            .doc(generatedotp)
                            .set({
                              'variable': 0,
                            })
                            .then((value) async {})
                            .onError((error, stackTrace) {});
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendPage(
                              roomCode: generatedotp,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: (screenHeight < 700) ? 50 : 60,
                        width: (screenHeight < 700) ? 150 : 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 53, 125, 145),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 205, 205, 205),
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "Create Room",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (screenHeight < 700) ? 18 : 22,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                          (screenWidth < 1300) ? 30 : screenWidth),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecievePage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: (screenHeight < 700) ? 50 : 60,
                        width: (screenHeight < 700) ? 150 : 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 53, 125, 145),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 205, 205, 205),
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "Join Room",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (screenHeight < 700) ? 18 : 22,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  Future<void> otpgenerator() async {
    generatedotp = genetor();
    var doc = await firestore.doc(generatedotp).get();
    while (doc.exists) {
      generatedotp = genetor();
      doc = await firestore.doc(generatedotp).get();
    }
  }

  String genetor() {
    var rand = Random();
    int opt = rand.nextInt(88888) + 10000;
    return opt.toString();
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent user from dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return const Center(
          child: SizedBox(
            height: 60,
            width: 60,
            child: SpinKitFadingFour(
              color: Colors.black,
              size: 50.0,
            ),
          ),
        );
      },
    );
  }
}
