// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:pinput/pinput.dart';
import 'package:quickshare/MyIconWidget.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:quickshare/connector.dart';

class RecievePage extends StatefulWidget {
  const RecievePage({super.key});

  @override
  State<RecievePage> createState() => _RecievePageState();
}

class _RecievePageState extends State<RecievePage> {
  String roomCode = "";
  String pinINPUT = "";
  bool entered = false;
  bool loading = false;
  double fieldHeight = 40;
  String codeerrormessage = "";
  bool fileloading = false;
  var firestore = FirebaseFirestore.instance.collection('users');
  String notestextfield = "";
  TextEditingController myController = TextEditingController();

  TextEditingController cont = TextEditingController();

  // ignore: unused_field
  late Timer _timer;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 50,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(0, 0, 0, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 250, 254),
        border: Border.all(
          color: (codeerrormessage == "")
              ? const Color.fromARGB(255, 162, 198, 208)
              : Colors.red,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(231, 33, 82, 96),
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              if (screenHeight > 200 && screenWidth > 250)
                Row(
                  children: [
                    if (screenWidth >= 800 || (screenWidth < 800 && !entered))
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 200, // Adjust the width as needed
                                    height: 200, // Adjust the height as needed
                                    child: Image.asset(
                                      'images/send.png', // Replace 'your_image.jpg' with your image asset path
                                      fit: BoxFit
                                          .cover, // Adjust the fit as needed
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Quick Share",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: (screenWidth < 1300)
                                          ? 28
                                          : screenWidth * 0.1 * 0.2,
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Row(
                                //   children: [
                                //     const SizedBox(
                                //       width: 50,
                                //     ),
                                //     Text(
                                //       "Quick",
                                //       style: GoogleFonts.poppins(
                                //           textStyle: TextStyle(
                                //         fontWeight: FontWeight.w700,
                                //         fontSize: (screenWidth < 1300)
                                //             ? 28
                                //             : screenWidth * 0.1 * 0.2,
                                //         color: const Color.fromARGB(255, 0, 0, 0),
                                //       )),
                                //     ),
                                //     Text(
                                //       "Share",
                                //       style: GoogleFonts.poppins(
                                //           textStyle: TextStyle(
                                //         fontWeight: FontWeight.w700,
                                //         fontSize: (screenWidth < 1300)
                                //             ? 28
                                //             : screenWidth * 0.1 * 0.2,
                                //         color:
                                //             const Color.fromARGB(255, 53, 125, 145),
                                //       )),
                                //     ),
                                //   ],
                                // ),
                                Container(
                                  margin: const EdgeInsets.only(right: 2),
                                  decoration: const BoxDecoration(
                                      // color: Color.fromARGB(231, 33, 82, 96),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Color.fromARGB(255, 53, 125, 145),
                                      //     offset: Offset(0, 0),
                                      //     blurRadius: 1.0,
                                      //     spreadRadius: 1.0,
                                      //   ),
                                      // ],
                                      // color: Color.fromARGB(255, 235, 250, 254)
                                      ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Column(
                                              children: [
                                                Pinput(
                                                  length: 5,
                                                  defaultPinTheme: PinTheme(
                                                    width: 40,
                                                    height: 50,
                                                    textStyle: const TextStyle(
                                                        fontSize: 20,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      border: Border.all(
                                                        color:
                                                            (codeerrormessage ==
                                                                    "")
                                                                ? const Color
                                                                    .fromARGB(
                                                                    231,
                                                                    33,
                                                                    82,
                                                                    96)
                                                                : Colors.red,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  focusedPinTheme:
                                                      defaultPinTheme
                                                          .copyDecorationWith(
                                                    color: const Color.fromRGBO(
                                                        142, 187, 199, 1),
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(255, 255,
                                                            255, 255)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  submittedPinTheme:
                                                      defaultPinTheme.copyWith(
                                                    // width: (screenWidth < 660)
                                                    //     ? 40
                                                    //     : screenWidth * 0.03,
                                                    // height: (screenWidth < 660)
                                                    //     ? 50
                                                    //     : screenHeight * 0.08,
                                                    decoration: defaultPinTheme
                                                        .decoration
                                                        ?.copyWith(
                                                      color:
                                                          const Color.fromRGBO(
                                                              142, 187, 199, 1),
                                                      border: Border.all(
                                                        color:
                                                            (codeerrormessage ==
                                                                    "")
                                                                ? const Color
                                                                    .fromRGBO(
                                                                    243,
                                                                    253,
                                                                    255,
                                                                    1)
                                                                : Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  pinputAutovalidateMode:
                                                      PinputAutovalidateMode
                                                          .onSubmit,
                                                  showCursor: true,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      pinINPUT = value;
                                                      codeerrormessage = "";
                                                    });
                                                  },
                                                ),
                                                if (codeerrormessage != "")
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                if (codeerrormessage != "")
                                                  Center(
                                                    child: Text(
                                                      codeerrormessage,
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize:
                                                            (screenWidth < 660)
                                                                ? 12
                                                                : screenWidth *
                                                                    0.01,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              try {
                                                if (pinINPUT.isEmpty ||
                                                    pinINPUT.contains(
                                                        RegExp(r'\D')) ||
                                                    pinINPUT.length != 5) {
                                                  setState(() {
                                                    codeerrormessage =
                                                        "Invalid Code";
                                                  });
                                                } else {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(pinINPUT)
                                                      .get()
                                                      .then((value) async {
                                                    bool documentExists =
                                                        await doesDocumentExist(
                                                            "users", pinINPUT);
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    if (documentExists) {
                                                      setState(() {
                                                        roomCode = pinINPUT;
                                                        entered = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        codeerrormessage =
                                                            "Code Invalid";
                                                      });
                                                    }
                                                  }).onError(
                                                          (error, stackTrace) {
                                                    setState(() {
                                                      codeerrormessage =
                                                          "Code Invalid";
                                                      loading = false;
                                                    });
                                                  });
                                                }
                                              } catch (e) {
                                                _showSnackBar(
                                                    context, "Invalid Code");
                                              }
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                const Color.fromRGBO(
                                                    243, 253, 255, 1),
                                              ),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              padding:
                                                  MaterialStateProperty.all(
                                                const EdgeInsets.fromLTRB(
                                                    80, 17, 80, 17),
                                              ),
                                              textStyle:
                                                  MaterialStateProperty.all(
                                                const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              overlayColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>((Set<
                                                              MaterialState>
                                                          states) {
                                                if (states.contains(
                                                    MaterialState.hovered)) {
                                                  return const Color.fromARGB(
                                                      255, 230, 230, 230);
                                                  // Change to the desired grey color
                                                }
                                                return const Color.fromARGB(
                                                    255, 230, 230, 230);
                                              }),
                                            ),
                                            child: SizedBox(
                                              width: 80,
                                              height: 30,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  if (!loading)
                                                    const Text(
                                                      "Join Room",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  if (loading)
                                                    const SpinKitFadingFour(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      size: 20,
                                                    ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (screenWidth >= 800 || (screenWidth < 800 && entered))
                      Flexible(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: (screenWidth < 800 && entered)
                                ? BorderRadius.circular(0)
                                : const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                            image: DecorationImage(
                              image: const AssetImage('images/chat_bg2.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                const Color.fromARGB(116, 0, 0, 0)
                                    .withOpacity(0.4),
                                BlendMode.dstATop,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              if (entered)
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: SizedBox(
                                      height: (screenHeight < 700)
                                          ? 60
                                          : screenHeight * 0.1,
                                      width: screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (entered)
                                            InkWell(
                                              onTap: () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                        text: roomCode));
                                                _showSnackBar(context,
                                                    'Code copied to clipboard');
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 230, 230, 230),
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons.copy,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      roomCode,
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        color: Color.fromARGB(
                                                            255, 94, 94, 94),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (entered)
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      1, 1, 1, 1),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 230, 230, 230),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: IconButton(
                                                color: Colors.grey,
                                                onPressed: () {
                                                  setState(() {
                                                    roomCode = "";
                                                    entered = false;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close_rounded,
                                                  size: 25,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                        ],
                                      )),
                                ),
                              Expanded(
                                child: SizedBox(
                                    child: Stack(
                                  children: [
                                    if (entered)
                                      Center(
                                        child: SizedBox(
                                          height: screenHeight * 0.77,
                                          width: screenWidth * 0.9,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/chatbg2.png'), // replace with the actual path to your image
                                                fit: BoxFit.cover,
                                              ),
                                              color: const Color.fromARGB(
                                                  0, 255, 255, 255),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            // child: ChatScreen(roomCode: roomCode),
                                            child: livescreen(context),
                                          ),
                                        ),
                                      ),
                                    if (!entered)
                                      Center(
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 230, 230, 230),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Text(
                                            "Enter room code to start chatting",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 126, 126, 126),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                              ),
                              if (entered)
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: fieldHeight,
                                          child: TextField(
                                            textInputAction:
                                                TextInputAction.continueAction,
                                            textAlignVertical:
                                                TextAlignVertical.bottom,
                                            controller: myController,
                                            onSubmitted: (value) {
                                              setState(() {
                                                fieldHeight = 60;
                                              });
                                            },
                                            onChanged: (value) {
                                              notestextfield = value;
                                              if (!notestextfield
                                                  .contains("\n")) {
                                                setState(() {
                                                  fieldHeight = 40;
                                                });
                                              }
                                            },
                                            cursorColor: Colors.black,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            minLines: 2,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 230, 230, 230),
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 10, 20, 10),
                                              hintText: 'Write a message here',
                                              hintStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 124, 124, 124)),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 40,
                                        width: (screenWidth < 450) ? 40 : 70,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              231, 33, 82, 96),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            if (myController.text.isNotEmpty &&
                                                roomCode != "") {
                                              setState(() {
                                                myController.text = "";
                                                fieldHeight = 40;
                                              });
                                              DocumentSnapshot d =
                                                  await firestore
                                                      .doc(roomCode)
                                                      .get();
                                              if (!d.exists) {
                                                firestore
                                                    .doc(roomCode)
                                                    .set({'variable': 0});
                                                int variable = 0;
                                                appendDataToDocument(roomCode,
                                                    notestextfield, variable);
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(roomCode)
                                                    .get()
                                                    .then((value) {
                                                  int variable =
                                                      value['variable'];
                                                  appendDataToDocument(roomCode,
                                                      notestextfield, variable);
                                                }).onError(
                                                        (error, stackTrace) {});
                                              }
                                            }
                                          },
                                          child: const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 40,
                                        width: (screenWidth < 450) ? 40 : 70,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              231, 33, 82, 96),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: IconButton(
                                            onPressed: () async {
                                              if (!fileloading &&
                                                  roomCode != "") {
                                                FilePickerResult? result =
                                                    await pickFile();
                                                if (result != null) {
                                                  setState(() {
                                                    fileloading = true;
                                                  });
                                                  await uploadFile(result);
                                                  setState(() {
                                                    fileloading = false;
                                                  });
                                                }
                                              }
                                            },
                                            icon: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                if (!fileloading)
                                                  const Icon(
                                                    Icons.attach_file_sharp,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                if (fileloading)
                                                  const SizedBox(
                                                    width: 24,
                                                    child: SpinKitFadingFour(
                                                      color: Colors.white,
                                                      size: 18.0,
                                                    ),
                                                  ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black, // Change background color
        duration: const Duration(seconds: 2), // Change duration
        behavior: SnackBarBehavior.floating, // Change behavior
        shape: RoundedRectangleBorder(
          // Change shape
          borderRadius: BorderRadius.circular(10.0),
        ),
        action: SnackBarAction(
          // Add an action
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget livescreen(BuildContext context) {
    if (cont.text != Connector.fetchData()) {
      cont.text = Connector.fetchData();
    }
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(roomCode)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return const Center(
            //   child: SpinKitFadingFour(
            //     color: Color.fromARGB(255, 140, 16, 16),
            //     size: 50.0,
            //   ),
            // );
            // return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Center(
              child: SpinKitFadingFour(
                color: Color.fromARGB(255, 0, 0, 0),
                size: 50.0,
              ),
            );
          }
          DocumentSnapshot document = snapshot.data as DocumentSnapshot;
          if (document.exists) {
            Map<String, dynamic> dataset =
                document.data() as Map<String, dynamic>;
            int x = dataset.length - 2;
            return ListView.builder(
              reverse: true,
              itemCount: dataset.length - 1,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data as DocumentSnapshot;
                Map<String, dynamic> dataset =
                    document.data() as Map<String, dynamic>;
                String data = dataset['${x - index}'];
                String substring = "";
                String name = data;
                bool cc = true;
                bool img = false;
                bool file = false;
                if (data.length > 40) {
                  substring = data.substring(0, 39);
                  if (substring == "https://firebasestorage.googleapis.com/") {
                    cc = false;
                    img = false;
                    file = true;
                    String vv = basename(data);
                    var x = vv.indexOf('?');
                    name = vv.substring(0, x);
                    String ext = name.substring(name.length - 4, name.length);
                    if (ext == ".png" ||
                        ext == ".jpg" ||
                        name.substring(name.length - 5, name.length) ==
                            ".jpeg") {
                      file = false;
                      img = true;
                    }
                  }
                }
                return ListTile(
                  title: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (!img &&
                                !file &&
                                name == "This message was deleted.")
                            ? const Color.fromARGB(152, 159, 204, 217)
                            // : Color.fromRGBO(218, 218, 218, 1),
                            : const Color.fromARGB(152, 159, 204, 217),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (img)
                            Flexible(
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  data,
                                  fit: BoxFit.contain,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Center(
                                        child: SpinKitFadingFour(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          size: 30.0,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.error),
                                    );
                                  },
                                ),
                              ),
                            ),
                          if (!img)
                            Expanded(
                              child: Stack(
                                children: [
                                  if (Connector.fetchEditMode() != index)
                                    Row(
                                      children: [
                                        if (file)
                                          const Icon(
                                            Icons.file_copy,
                                            size: 25,
                                            color: Color.fromARGB(192, 0, 0, 0),
                                          ),
                                        if (file)
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        if (file)
                                          Text(
                                            name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        if (!file)
                                          Expanded(
                                            child: SelectableText(
                                              name,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                      ],
                                    ),
                                  if (Connector.fetchEditMode() == index)
                                    SizedBox(
                                      height: 40,
                                      child: TextField(
                                        maxLines:
                                            null, // or set to a higher value
                                        keyboardType: TextInputType.multiline,
                                        textInputAction:
                                            TextInputAction.newline,
                                        controller: cont,
                                        // controller: TextEditingController(text: (name==Connector.fetchData()) ? name : Connector.fetchData()),
                                        onChanged: (value) {
                                          Connector.setData(value);
                                        },
                                        style: const TextStyle(
                                            color:
                                                Colors.black), // Set text color
                                        cursorColor:
                                            Colors.black, // Set cursor color
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  25, 3, 25, 3),
                                          hintText: 'Enter text',
                                          hintStyle: TextStyle(
                                              color: Colors.white.withOpacity(
                                                  0.5)), // Set hint text color
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white.withOpacity(
                                                    0.5)), // Set border color
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white.withOpacity(
                                                    0.5)), // Set enabled border color
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white.withOpacity(
                                                    1)), // Set focused border color
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          MyIconWidget(
                            edit: (Connector.fetchEditMode() != -1),
                            message: cc,
                            image: img,
                            data: data,
                            index: index,
                            fetchedvar: x - index,
                            documentId: roomCode,
                          ),
                        ],
                      )),
                );
              },
            );
          } else {
            return const Text('No data available');
          }
        });
  }

  Future<bool> doesDocumentExist(
      String collectionName, String documentId) async {
    try {
      // Get a reference to the document
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection(collectionName).doc(documentId);

      // Get the document snapshot
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      return documentSnapshot.exists;
    } catch (e) {
      return false; // Return false in case of an error
    }
  }

  Future<FilePickerResult?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      return result;
    } catch (e) {
      print("Error picking file: $e");
      return null;
    }
  }

  Future<void> uploadFile(FilePickerResult result) async {
    try {
      // ignore: unnecessary_null_comparison
      if (result != null) {
        Uint8List bytes; // Check if running on web
        if (result.files.first.bytes != null) {
          // Use the bytes property for web
          bytes = Uint8List.fromList(result.files.first.bytes!);
        } else {
          // For mobile platforms, use the local path
          File file = File(result.files.single.path!);
          bytes = await file.readAsBytes();
        }
        String fileName = result.files.single.name;
        fileName = fileName.replaceAll(' ', '_');
        firebase_storage.Reference reference =
            firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        String name = result.files.single.name;
        String ext = name.substring(name.length - 4, name.length);
        if (ext == ".png") {
          firebase_storage.SettableMetadata metadata =
              firebase_storage.SettableMetadata(contentType: 'image/png');
          await reference.putData(bytes, metadata);
        } else if (ext == ".jpg") {
          firebase_storage.SettableMetadata metadata =
              firebase_storage.SettableMetadata(contentType: 'image/jpg');
          await reference.putData(bytes, metadata);
        } else if (name.substring(name.length - 5, name.length) == ".jpeg") {
          firebase_storage.SettableMetadata metadata =
              firebase_storage.SettableMetadata(contentType: 'image/jpeg');
          await reference.putData(bytes, metadata);
        } else {
          await reference.putData(bytes);
        }
        String downloadURL = await reference.getDownloadURL();
        DocumentSnapshot d = await firestore.doc(roomCode).get();
        if (!d.exists) {
          firestore.doc(roomCode).set({'variable': 0});
          int variable = 0;
          appendDataToDocument(roomCode, downloadURL, variable);
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(roomCode)
              .get()
              .then((value) {
            int variable = value['variable'];
            appendDataToDocument(roomCode, downloadURL, variable);
          }).onError((error, stackTrace) {});
        }

        print("File uploaded successfully!");
      } else {
        print("No file picked.");
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  Future<void> appendDataToDocument(
      String documentId, String data, int variable1) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    try {
      // Get the current data from the document
      DocumentSnapshot documentSnapshot =
          await usersCollection.doc(documentId).get();

      // Extract the existing data
      Map<String, dynamic> existingData =
          documentSnapshot.data() as Map<String, dynamic>;

      // Append or modify the data as needed
      existingData['$variable1'] = data;
      existingData['variable'] = variable1 + 1;

      // Update the document with the modified data
      await usersCollection
          .doc(documentId)
          .set(existingData, SetOptions(merge: true));
    } catch (e) {
      // Handle any errors
      print('Error appending data: $e');
    }
  }
}
