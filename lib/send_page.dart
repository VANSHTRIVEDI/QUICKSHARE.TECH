// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:quickshare/MyIconWidget.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:quickshare/connector.dart';

// ignore: must_be_immutable
class SendPage extends StatefulWidget {
  String roomCode;
  SendPage({required this.roomCode, super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool chatting = false;
  String codeerrormessage = "";
  bool fileloading = false;
  double fieldHeight = 40;
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
    _scaffoldKey;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(231, 33, 82, 96),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            // if (screenHeight > 200)
            if (screenHeight > 200 && screenWidth > 250)
              Row(
                children: [
                  if (screenWidth > 800)
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 2),
                        // decoration: const BoxDecoration(boxShadow: [
                        //   // BoxShadow(
                        //   //   color: Color.fromARGB(255, 211, 211, 211),
                        //   //   offset: Offset(0, 0),
                        //   //   blurRadius: 1.0,
                        //   //   spreadRadius: 1.0,
                        //   // ),
                        // ], color: Colors.white),
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
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            codePrint(widget.roomCode[0]),
                                            codePrint(widget.roomCode[1]),
                                            codePrint(widget.roomCode[2]),
                                            codePrint(widget.roomCode[3]),
                                            codePrint(widget.roomCode[4]),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                        text: widget.roomCode));
                                                _showSnackBar(context,
                                                    'Code copied to clipboard');
                                              },
                                              child: Container(
                                                height: 45,
                                                width: 40,
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 230, 230, 230),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Icon(
                                                  Icons.copy,
                                                  size: 20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: (screenWidth < 800)
                            ? BorderRadius.circular(0)
                            : const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                        image: DecorationImage(
                          image: const AssetImage('images/chat_bg2.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            const Color.fromARGB(116, 0, 0, 0).withOpacity(0.4),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 30, right: 30),

                            // decoration: const BoxDecoration(
                            //   color: Colors.white,
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Color.fromARGB(255, 211, 211, 211),
                            //       offset: Offset(3, 0),
                            //       blurRadius: 1.0, // Blur radius
                            //       spreadRadius: 1.0, // Spread radius
                            //     ),
                            //   ],
                            // ),
                            child: SizedBox(
                                height: (screenHeight < 700)
                                    ? 60
                                    : screenHeight * 0.1,
                                width: screenWidth,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: widget.roomCode));
                                        _showSnackBar(context,
                                            'Code copied to clipboard');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
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
                                              widget.roomCode,
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
                                    Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(1, 1, 1, 1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 230, 230, 230),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(
                                        color: Colors.grey,
                                        onPressed: () {
                                          Navigator.pop(context, false);
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
                                if (chatting)
                                  Center(
                                    child: SizedBox(
                                      height: screenHeight * 0.77,
                                      width: screenWidth * 0.9,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              0, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: livescreen(context),
                                      ),
                                    ),
                                  ),
                              ],
                            )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                                        if (!notestextfield.contains("\n")) {
                                          setState(() {
                                            fieldHeight = 40;
                                          });
                                        }
                                      },
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.multiline,
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
                                    color:
                                        const Color.fromARGB(231, 33, 82, 96),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      if (myController.text.isNotEmpty) {
                                        setState(() {
                                          myController.text = "";
                                          fieldHeight = 40;
                                        });
                                        DocumentSnapshot d = await firestore
                                            .doc(widget.roomCode)
                                            .get();
                                        if (!d.exists) {
                                          firestore
                                              .doc(widget.roomCode)
                                              .set({'variable': 0});
                                          int variable = 0;
                                          appendDataToDocument(widget.roomCode,
                                              notestextfield, variable);
                                        } else {
                                          chatting = true;
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.roomCode)
                                              .get()
                                              .then((value) {
                                            int variable = value['variable'];
                                            appendDataToDocument(
                                                widget.roomCode,
                                                notestextfield,
                                                variable);
                                          }).onError((error, stackTrace) {});
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
                                    color:
                                        const Color.fromARGB(231, 33, 82, 96),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: IconButton(
                                      onPressed: () async {
                                        if (!fileloading &&
                                            widget.roomCode != "") {
                                          FilePickerResult? result =
                                              await pickFile();
                                          if (result != null) {
                                            setState(() {
                                              fileloading = true;
                                            });
                                            await uploadFile(result);
                                            setState(() {
                                              fileloading = false;
                                              chatting = true;
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
    );
  }

  Widget codePrint(String s) {
    return Container(
      height: 45,
      width: 30,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
        s,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget livescreen(BuildContext context) {
    if (cont.text != Connector.fetchData()) {
      cont.text = Connector.fetchData();
    }
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.roomCode)
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
                            documentId: widget.roomCode,
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

  Widget livescreen2(BuildContext context) {
    if (cont.text != Connector.fetchData()) {
      cont.text = Connector.fetchData();
    }
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.roomCode)
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
                      img = true;
                      file = false;
                    }
                  }
                }
                return ListTile(
                  title: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(152, 159, 204, 217),
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
                                    return const SizedBox(
                                      height: 5,
                                      width: 5,
                                      child: Icon(Icons.error),
                                    );
                                  },
                                ),
                              ),
                            ),
                          if (!img)
                            Expanded(
                              // width: screenWidth * 0.5,
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
                                          SelectableText(
                                            name,
                                            style: const TextStyle(
                                                color: Colors.black),
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
                            documentId: widget.roomCode,
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
        // ------------------------------------
        // ------------------------------------
        // ------------------------------------
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
        // ------------------------------------
        // ------------------------------------
        // ------------------------------------
        String downloadURL = await reference.getDownloadURL();
        DocumentSnapshot d = await firestore.doc(widget.roomCode).get();
        if (!d.exists) {
          firestore.doc(widget.roomCode).set({'variable': 0});
          int variable = 0;
          appendDataToDocument(widget.roomCode, downloadURL, variable);
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.roomCode)
              .get()
              .then((value) {
            int variable = value['variable'];
            appendDataToDocument(widget.roomCode, downloadURL, variable);
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
