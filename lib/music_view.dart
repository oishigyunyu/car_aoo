import 'dart:ui';

import 'package:flutter/material.dart';

class MusicView extends StatelessWidget {
  const MusicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/static/images/vaundy_strobo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: const ColorFilter.mode(Colors.black38, BlendMode.darken),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: size.width / 4,
                        height: size.width / 4,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/static/images/vaundy_strobo.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: size.width / 4,
                        height: size.width / 4,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Strobo"),
                              Text("Vaundy"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.skip_previous_outlined),
                                  IconButton(icon: Icon(Icons.play_arrow_outlined),
                                  ),
                                  Icon(Icons.skip_next_outlined),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
