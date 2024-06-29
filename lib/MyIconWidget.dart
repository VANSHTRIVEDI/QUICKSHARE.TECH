import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickshare/connector.dart';
import 'package:url_launcher/url_launcher.dart';

class MyIconWidget extends StatefulWidget {
  final bool message;
  final bool image;
  final bool edit;
  final String data;
  final String documentId;
  final int fetchedvar;
  final int index;

  const MyIconWidget({
    super.key,
    required this.message,
    required this.edit,
    required this.index,
    required this.documentId,
    required this.image,
    required this.data,
    required this.fetchedvar,
  });

  @override
  _MyIconWidgetState createState() => _MyIconWidgetState();
}

class _MyIconWidgetState extends State<MyIconWidget> {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');
  bool hover = false;
  bool editMode = false;
  var myController = TextEditingController();
  String notestextfield = "";
  @override
  Widget build(BuildContext context) {
    // double sw = MediaQuery.of(context).size.width;
    // double sh = MediaQuery.of(context).size.height;
    if (widget.data == "This message is deleted.") {
      return Container();
    } else if (!widget.image) {
      return MouseRegion(
        onEnter: (F) {
          setState(() {
            hover = true;
          });
        },
        onExit: (F) {
          setState(() {
            hover = false;
          });
        },
        child: Row(
          children: [
            if (widget.edit && widget.index == Connector.fetchEditMode())
              IconButton(
                onPressed: () async {
                  // Connector.setData(widget.data);
                  await editMessage(widget.documentId, widget.fetchedvar,
                      Connector.fetchData());
                  Connector.setEditMode(-1);
                  Connector.setData("");
                },
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 22,
                ),
              ),
            if (widget.edit && widget.index == Connector.fetchEditMode())
              IconButton(
                onPressed: () async {
                  Connector.setEditMode(-1);
                  Connector.setData("");
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 22,
                ),
              ),
            if (!(widget.edit && widget.index == Connector.fetchEditMode()))
              Column(
                children: [
                  if (widget.message)
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: widget.data));
                        _showSnackBar(context, 'Message copied to clipboard');
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  if (widget.message)
                    IconButton(
                      onPressed: () async {
                        print("button clicked");
                        setState(() {
                          Connector.setEditMode(widget.index);
                          Connector.setData(widget.data);
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  if (!widget.message)
                    IconButton(
                        onPressed: () async {
                          try {
                            final uri = Uri.parse(widget.data);
                            if (await canLaunchUrl(uri)) {
                              launchUrl(uri);
                            } else {
                              throw 'Could not launch ${widget.data}';
                            }
                            // ignore: empty_catches
                          } catch (e) {}
                        },
                        icon: const Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                          size: 18,
                        )),
                  IconButton(
                    onPressed: () async {
                      deleteMessage(widget.documentId, widget.fetchedvar);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    } else {
      return MouseRegion(
        onEnter: (F) {
          setState(() {
            hover = true;
          });
        },
        onExit: (F) {
          setState(() {
            hover = false;
          });
        },
        child: Column(
          children: [
            IconButton(
                onPressed: () async {
                  try {
                    final uri = Uri.parse(widget.data);
                    print('1');
                    if (await canLaunchUrl(uri)) {
                      launchUrl(uri);
                    } else {
                      print('11');
                      throw 'Could not launch ${widget.data}';
                    }
                    // Your code that might throw an exception
                  } catch (e) {
                    // Handle the exception
                    print('Error: $e');
                  }
                },
                icon: const Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  size: 18,
                )),
            IconButton(
              onPressed: () async {
                deleteMessage(widget.documentId, widget.fetchedvar);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 17,
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> deleteMessage(String documentId, int variable) async {
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
      existingData['$variable'] = "This message is deleted.";

      // Update the document with the modified data
      await usersCollection
          .doc(documentId)
          .set(existingData, SetOptions(merge: true));
    } catch (e) {
      // Handle any errors
      print('Error appending data: $e');
    }
  }

  Future<void> editMessage(String documentId, int variable, String data) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    try {
      print("Document ID : $documentId");
      print("Variable : $variable");
      print("Data Text : $data");
      // Get the current data from the document
      DocumentSnapshot documentSnapshot =
          await usersCollection.doc(documentId).get();

      // Extract the existing data
      Map<String, dynamic> existingData =
          documentSnapshot.data() as Map<String, dynamic>;

      // Append or modify the data as needed
      existingData['$variable'] = data;

      // Update the document with the modified data
      await usersCollection
          .doc(documentId)
          .set(existingData, SetOptions(merge: true));
    } catch (e) {
      // Handle any errors
      print('Error appending data: $e');
    }
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
}
