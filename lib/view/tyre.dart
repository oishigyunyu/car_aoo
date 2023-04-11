import 'package:flutter/material.dart';

class Tyre extends StatefulWidget {
  final String tyreName;
  const Tyre({Key? key, required this.tyreName}) : super(key: key);

  @override
  State<Tyre> createState() => _TyreState();
}

class _TyreState extends State<Tyre> {
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
          child: Stack(
            children: <Widget>[
              Center(
                child: Text(
                  widget.tyreName,
                  style: Theme.of(context).textTheme.headlineSmall?.apply(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.large(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.keyboard_return),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
