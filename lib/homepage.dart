// ignore_for_file: avoid_print, unused_element, camel_case_types, duplicate_ignore

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickshare/connector.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:quickshare/developers.dart';
import 'package:quickshare/recieve_page.dart';
import 'package:quickshare/send_page.dart';
import 'MyIconWidget.dart';

// ignore: camel_case_types
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int otp = 0;
  double x = 0;
  double y = 0;
  String dropdownvalue = 'Code';
  String inputotp = "";
  String otpinstringform = "";
  String shareviacode = "Share via Code";
  String sharevialink = "Share via Link";
  bool codeclick = true;
  bool linkclick = true;
  String inputnotes = "";
  String notes = "";
  String codedisplay = "";
  String linkdisplay = "";
  String errormessage = "";
  String codeerrormessage = "";
  Color errorcolor = const Color.fromARGB(255, 0, 0, 0);
  Color col = const Color.fromRGBO(38, 36, 45, 1);
  String notestextfield = "";
  int variable = 0;
  bool isHovered = false;
  String generatedotp = "";
  bool generate = false;
  bool fileloading = false;
  Color tilehover = const Color.fromARGB(255, 0, 0, 0);

  var firestore = FirebaseFirestore.instance.collection('users');
  final myController = TextEditingController();

  void reversetext() {
    setState(() {
      generate = false;
      col = const Color.fromRGBO(38, 36, 45, 1);
      notes = "";
      codedisplay = "";
      myController.text = "";
      linkdisplay = "";
      errormessage = "";
      codeclick = true;
      linkclick = true;
      shareviacode = "Share via Code";
      sharevialink = "Share via Link";
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double x = screenWidth * 0.1;
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
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 53, 125, 145),
                      borderRadius: BorderRadius.circular(100)),
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Image.asset(
                    'images/send.png', // Replace 'your_icon.png' with your actual icon asset path
                    width: 45, // Adjust width as needed
                    height:
                        45, // Adjust height as needed// Adjust color as needed
                  ),
                ),
                const SizedBox(
                  width: 8, // Adjust spacing between icon and text as needed
                ),
                Text(
                  "Quick",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: (screenWidth < 1300) ? 28 : x * 0.2,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    // color: Colors.white,
                  )),
                ),
                Text(
                  "Share",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: (screenWidth < 1300) ? 28 : x * 0.2,
                    color: const Color.fromARGB(255, 53, 125, 145),
                  )),
                ),
              ],
            ),
            InkWell(
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
            )
          ],
        ),
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: (screenWidth < 1300) ? 600 : screenWidth * 0.45,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(55, 55, 0, 55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "Quick Share :\nConnect Effortlessly  \nShare Anonymously",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        (screenWidth < 1300) ? 40 : x * 0.33,
                                    fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(
                            height: (screenWidth < 1300) ? 20 : x * 0.2,
                          ),
                          SelectableText(
                            "Create or join rooms with codes to chat and share files hassle-free - no sign-in needed!",
                            style: TextStyle(
                                fontSize: (screenWidth < 1300) ? 19 : x * 0.2,
                                fontWeight: FontWeight.w300,
                                color:
                                    const Color.fromARGB(255, 135, 135, 135)),
                          ),
                          SizedBox(
                            height: (screenWidth < 1300) ? 30 : x * 0.3,
                          ),
                          Row(
                            children: [
                              InkWell(
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
                                  // Navigator.push(context,
                                  //   MaterialPageRoute(builder: (context) =>
                                  //     Send(generatedotp: generatedotp),
                                  //   ),
                                  // );
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
                                  height: (screenWidth < 1300) ? 50 : x * 0.33,
                                  width: (screenWidth < 1300) ? 150 : x * 1.1,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 53, 125, 145),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 205, 205, 205),
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
                                        fontSize: (screenWidth < 1300)
                                            ? 16
                                            : x * 0.13,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: (screenWidth < 1300) ? 50 : x * 0.4,
                              ),
                              InkWell(
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
                                  height: (screenWidth < 1300) ? 50 : x * 0.33,
                                  width: (screenWidth < 1300) ? 150 : x * 1.1,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 53, 125, 145),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 205, 205, 205),
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
                                        fontSize: (screenWidth < 1300)
                                            ? 16
                                            : x * 0.13,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  width: (screenWidth < 1300) ? 600 : screenWidth * 0.55,
                  child: Center(
                    child: Image.asset(
                      "images/title_image.png",
                      height: (screenWidth < 1300) ? 500 : screenWidth * 0.4,
                      width: (screenWidth < 1300) ? 500 : screenWidth * 0.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String genetor() {
    var rand = Random();
    int opt = rand.nextInt(88888) + 10000;
    return opt.toString();
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

  Future<void> otpgenerator() async {
    generatedotp = genetor();
    var doc = await firestore.doc(generatedotp).get();
    while (doc.exists) {
      generatedotp = genetor();
      doc = await firestore.doc(generatedotp).get();
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

        await reference.putData(bytes);
        String downloadURL = await reference.getDownloadURL();
        DocumentSnapshot d = await firestore.doc(generatedotp).get();
        if (!d.exists) {
          firestore.doc(generatedotp).set({'variable': 0});
          variable = 0;
          appendDataToDocument(generatedotp, downloadURL, variable);
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(generatedotp)
              .get()
              .then((value) {
            variable = value['variable'];
            appendDataToDocument(generatedotp, downloadURL, variable);
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

  livescreen(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(generatedotp)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Display a loading indicator while data is loading.
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Text(
                'No data available'); // Handle the case when there's no data.
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
                if (data.length > 40) {
                  substring = data.substring(0, 39);
                  if (substring == "https://firebasestorage.googleapis.com/") {
                    cc = false;
                    img = false;
                    String vv = basename(data);
                    var x = vv.indexOf('?');
                    print(x);
                    name = vv.substring(0, x);
                    String ext = name.substring(name.length - 4, name.length);
                    if (ext == ".png" ||
                        ext == ".jpg" ||
                        name.substring(name.length - 5, name.length) ==
                            ".jpeg") {
                      img = true;
                    }
                  }
                }
                return ListTile(
                  title: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 51, 48, 59),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (img)
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
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
                                        size: 50.0,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return Container(
                                    height: 0,
                                  );
                                },
                              ),
                            ),
                          if (!img)
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.29,
                              child: SelectableText(
                                name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          MyIconWidget(
                            edit: Connector.fetchEditMode() == -1,
                            message: cc,
                            image: img,
                            index: index,
                            data: data,
                            fetchedvar: x - index,
                            documentId: generatedotp,
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

  Future<void> _dialogBuilder(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: false,
      context: context,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (BuildContext context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                scrollable: true,
                alignment: Alignment.center,
                backgroundColor: const Color.fromRGBO(54, 54, 54, 1),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(),
                ),
              );
            }),
          ),
        );
      },
    );
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

  Future<bool> isImageFile(String downloadUrl) async {
    try {
      final response = await http.head(Uri.parse(downloadUrl));

      // Check if the response contains content type
      if (response.headers.containsKey('content-type')) {
        final contentType = response.headers['content-type'];

        // Check if the content type indicates an image
        return contentType?.startsWith('image/') ?? false;
      } else {
        // If content type is not available, assume it's not an image
        return false;
      }
    } catch (e) {
      // Handle the exception (e.g., network error)
      print('Error checking file type: $e');
      return false;
    }
  }
}
