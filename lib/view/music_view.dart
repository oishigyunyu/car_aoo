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
                            children: const <Widget>[
                              Text("Strobo"),
                              Text("Vaundy"),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Buttons(),
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
          ),
        ),
      ),
    );
  }
}

class Buttons extends StatefulWidget {
  final double size;
  const Buttons({Key? key, this.size = 30.0}) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        PlayBackButton(
          size: widget.size,
        ),
        PlayButton(
          size: widget.size,
        ),
        SkipButton(
          size: widget.size,
        ),
      ],
    );
  }
}

class PlayButton extends StatefulWidget {
  final double size;
  const PlayButton({Key? key, required this.size}) : super(key: key);

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool isPressed = false;
  IconData icon = Icons.play_arrow_outlined;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        isPressed = !isPressed;
        setState(() {
          icon = isPressed ? Icons.pause : Icons.play_arrow_outlined;
        });
      },
      icon: Icon(
        icon,
        size: widget.size,
      ),
    );
  }
}

class PlayBackButton extends StatefulWidget {
  final double size;
  const PlayBackButton({Key? key, required this.size}) : super(key: key);

  @override
  State<PlayBackButton> createState() => _PlayBackButtonState();
}

class _PlayBackButtonState extends State<PlayBackButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.skip_previous_outlined,
        size: widget.size,
      ),
    );
  }
}

class SkipButton extends StatefulWidget {
  final double size;
  const SkipButton({Key? key, required this.size}) : super(key: key);

  @override
  State<SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        print('skipped');
      },
      icon: Icon(
        Icons.skip_next_outlined,
        size: widget.size,
      ),
    );
  }
}
