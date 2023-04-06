import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          color: Theme.of(context).colorScheme.background,
          child: Center(
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: size.width / 5,
                  height: size.height / 5,
                  child: const Center(
                    child: Text("WIP"),
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
