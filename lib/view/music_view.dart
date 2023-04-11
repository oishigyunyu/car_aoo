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
                        width: size.width / 3,
                        height: size.width / 3,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('vaundy_strobo.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      SizedBox(
                        width: size.height / 6,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: size.width / 3,
                        height: size.width / 3,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Strobo",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Text(
                                    "Vaundy",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                              const Buttons(
                                size: 50,
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
  IconData icon = Icons.play_arrow_rounded;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        isPressed = !isPressed;
        setState(() {
          icon = isPressed ? Icons.pause_rounded : Icons.play_arrow_rounded;
        });
      },
      icon: Icon(
        icon,
        size: widget.size,
        color: Theme.of(context).colorScheme.surface,
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
        Icons.skip_previous_rounded,
        size: widget.size,
        color: Theme.of(context).colorScheme.surface,
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
        Icons.skip_next_rounded,
        size: widget.size,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
