import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Developers extends StatefulWidget {
  const Developers({super.key});

  @override
  State<Developers> createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    if (screenWidth < 240) {
      return const Scaffold(
        backgroundColor: Color.fromARGB(231, 33, 82, 96),
      );
    } else {
      return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        backgroundColor: const Color.fromRGBO(220, 238, 241, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          shadowColor: const Color.fromARGB(255, 240, 240, 240),
          elevation: 2,
          title: Center(
            child: Text(
              "QuickShare Developers",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Wrap(
                children: [
                  Container(
                    height: 400,
                    width: 330,
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 254, 255, 254),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 195, 218, 223),
                              ),
                              child: Image.asset(
                                'images/vanshbgimage2.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                Text(
                                  'Vansh Rohit Trivedi',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  )),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  'Btech(CSE) 3rd year',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        hoverColor: const Color.fromARGB(
                                            255, 96, 96, 96),
                                        highlightColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onPressed: () async {
                                          if (await canLaunchUrl(Uri.parse(
                                              'https://www.linkedin.com/in/vansh-trivedi-173074249/'))) {
                                            await launchUrl(Uri.parse(
                                                'https://www.linkedin.com/in/vansh-trivedi-173074249/'));
                                          } else {
                                            throw 'Could not launch the Instagram URL';
                                          }
                                        },
                                        icon: const Center(
                                          child: Icon(
                                            FontAwesomeIcons.linkedin,
                                            color: Colors.white,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        hoverColor: const Color.fromARGB(
                                            255, 96, 96, 96),
                                        highlightColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onPressed: () async {
                                          if (await canLaunchUrl(Uri.parse(
                                              'https://www.instagram.com/___vannsh___/'))) {
                                            await launchUrl(Uri.parse(
                                                'https://www.instagram.com/___vannsh___/'));
                                          } else {
                                            throw 'Could not launch the Instagram URL';
                                          }
                                        },
                                        icon: const Center(
                                          child: Icon(
                                            FontAwesomeIcons.instagram,
                                            color: Colors.white,
                                            size: 23.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        hoverColor: const Color.fromARGB(
                                            255, 96, 96, 96),
                                        highlightColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onPressed: () async {
                                          if (await canLaunchUrl(Uri.parse(
                                              'https://github.com/VANSHTRIVEDI'))) {
                                            await launchUrl(Uri.parse(
                                                'https://github.com/VANSHTRIVEDI'));
                                          } else {
                                            throw 'Could not launch the Instagram URL';
                                          }
                                        },
                                        icon: const Center(
                                          child: Icon(
                                            FontAwesomeIcons.github,
                                            color: Colors.white,
                                            size: 23.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 400,
                    width: 330,
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 254, 255, 254),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 195, 218, 223),
                              ),
                              child: Image.asset(
                                'images/omprofile.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                Text(
                                  'Om Singh',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  )),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  'Btech(CSE) 3rd year',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        hoverColor: const Color.fromARGB(
                                            255, 96, 96, 96),
                                        highlightColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onPressed: () async {
                                          if (await canLaunchUrl(Uri.parse(
                                              'https://www.linkedin.com/in/om-singh-8aa95b222/'))) {
                                            await launchUrl(Uri.parse(
                                                'https://www.linkedin.com/in/om-singh-8aa95b222/'));
                                          } else {
                                            throw 'Could not launch the Instagram URL';
                                          }
                                        },
                                        icon: const Center(
                                          child: Icon(
                                            FontAwesomeIcons.linkedin,
                                            color: Colors.white,
                                            size: 23.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        hoverColor: const Color.fromARGB(
                                            255, 96, 96, 96),
                                        highlightColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onPressed: () async {
                                          if (await canLaunchUrl(Uri.parse(
                                              'https://www.instagram.com/_0m_singh_/'))) {
                                            await launchUrl(Uri.parse(
                                                'https://www.instagram.com/_0m_singh_/'));
                                          } else {
                                            throw 'Could not launch the Instagram URL';
                                          }
                                        },
                                        icon: const Center(
                                          child: Icon(
                                            FontAwesomeIcons.instagram,
                                            color: Colors.white,
                                            size: 23.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        hoverColor: const Color.fromARGB(
                                            255, 96, 96, 96),
                                        highlightColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        onPressed: () async {
                                          if (await canLaunchUrl(Uri.parse(
                                              'https://github.com/omsingh32123'))) {
                                            await launchUrl(Uri.parse(
                                                'https://github.com/omsingh32123'));
                                          } else {
                                            throw 'Could not launch the Instagram URL';
                                          }
                                        },
                                        icon: const Center(
                                          child: Icon(
                                            FontAwesomeIcons.github,
                                            color: Colors.white,
                                            size: 23.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
            ),
          ),
        ),
      );
    }
  }
}
