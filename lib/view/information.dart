import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      left: false,
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/static/images/dash.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
