import 'package:flutter/material.dart';

class TyreInformation extends StatefulWidget {
  final String tyreName;
  const TyreInformation({Key? key, required this.tyreName}) : super(key: key);

  @override
  State<TyreInformation> createState() => _TyreInformationState();
}

class _TyreInformationState extends State<TyreInformation> {
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
                      color: Theme.of(context).colorScheme.onBackground),
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
