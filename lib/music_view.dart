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
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: SizedBox(
              width: size.width / 5,
              height: size.height / 3,
              child: const Center(
                child: Text("sss"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
