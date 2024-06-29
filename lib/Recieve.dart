import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:quickshare/connector.dart';
import 'dart:io';
import 'MyIconWidget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// ignore: must_be_immutable
class Receive extends StatefulWidget {
  const Receive({super.key});

  @override
  State<Receive> createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  String generatedotp = "";
  int variable = 0;
  String notestextfield = "";
  bool fileloading = false;
  bool generate = false;
  final myController = TextEditingController();
  var firestore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 24, 31),
      appBar: AppBar(
        title: const Text("Quick Share"),
      ),
      body: SizedBox(
        height: screenHeight,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Your Notes",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 214, 214, 214),
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 430,
                  width: screenWidth * 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(38, 36, 45, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: livescreen(context, screenWidth * 0.9),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FittedBox(
                  fit: BoxFit.cover,
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(38, 36, 45, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: (screenWidth * 0.9) - 140,
                              child: TextField(
                                controller: myController,
                                onChanged: (value) {
                                  notestextfield = value;
                                },
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(30, 10, 20, 10),
                                  hintText: 'Send Notes',
                                  hintStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 183, 183, 183)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 50, 47, 62),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  if (myController.text.isNotEmpty) {
                                    setState(() {
                                      myController.text = "";
                                      generate = true;
                                    });
                                    DocumentSnapshot d =
                                        await firestore.doc(generatedotp).get();
                                    if (!d.exists) {
                                      firestore
                                          .doc(generatedotp)
                                          .set({'variable': 0});
                                      variable = 0;
                                      print("variable 1 =  $variable");
                                      print("OTP = $generatedotp");
                                      appendDataToDocument(generatedotp,
                                          notestextfield, variable);
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(generatedotp)
                                          .get()
                                          .then((value) {
                                        variable = value['variable'];
                                        print(
                                            "variable recieved $generatedotp");
                                        print("variable 1 =  $variable");
                                        print("OTP = $generatedotp");
                                        appendDataToDocument(generatedotp,
                                            notestextfield, variable);
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
                            Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 50, 47, 62),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: IconButton(
                                  onPressed: () async {
                                    if (!fileloading) {
                                      FilePickerResult? result =
                                          await pickFile();
                                      if (result != null) {
                                        setState(() {
                                          fileloading = true;
                                        });
                                        await uploadFile(result);
                                        setState(() {
                                          generate = true;
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
                                          color: Color.fromARGB(
                                              255, 214, 214, 214),
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
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void reversetext() {
    setState(() {
      generate = false;
      myController.text = "";
    });
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

  livescreen(BuildContext context, double sw) {
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
                      // padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
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
                              width: sw * 0.5,
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
}
