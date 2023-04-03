import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text(
              'Work in progres...',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
