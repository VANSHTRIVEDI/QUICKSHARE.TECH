import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatefulWidget {
  const FrostedGlassBox(
      {Key? key,
      required this.theWidth,
      required this.theHeight,
      required this.theChild,})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final theWidth;
  // ignore: prefer_typing_uninitialized_variables
  final theHeight;
  // ignore: prefer_typing_uninitialized_variables
  final theChild;

  @override
  State<FrostedGlassBox> createState() => _FrostedGlassBoxState();
}

class _FrostedGlassBoxState extends State<FrostedGlassBox> {
  bool ishover = false;
  @override
  Widget build(BuildContext context) {
    bool ishover = false;
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: StatefulBuilder(
        builder: (context, setState) {
          return InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                ishover = value;
              });
            },
            child: Container(
              width: widget.theWidth,
              height: widget.theHeight,
              color: Colors.transparent,
              //we use Stack(); because we want the effects be on top of each other,
              //  just like layer in photoshop.
              child: Stack(
                children: [
                  //blur effect ==> the third layer of stack
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      //sigmaX is the Horizontal blur
                      sigmaX: (ishover) ? 8.0 : 4.0,
                      //sigmaY is the Vertical blur
                      sigmaY: (ishover) ? 8.0 : 4.0,
                    ),
                    //we use this container to scale up the blur effect to fit its
                    //  parent, without this container the blur effect doesn't appear.
                    child: Container(),
                  ),
                  //gradient effect ==> the second layer of stack
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.6)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            //begin color
                            const Color.fromARGB(255, 213, 213, 213).withOpacity((ishover) ? 0.04 : 0.05),
                            //end color
                            const Color.fromARGB(255, 213, 213, 213).withOpacity((ishover) ? 0.04 : 0.05),
                          ]),
                    ),
                  ),
                  //child ==> the first/top layer of stack
                  Center(child: widget.theChild),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
