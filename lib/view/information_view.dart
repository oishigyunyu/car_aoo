import 'package:flutter/material.dart';

class InformationView extends StatelessWidget {
  const InformationView({Key? key}) : super(key: key);

  Widget _buildHistoryCardWidget(
      BuildContext context, String text) {
    return ListTile(
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.apply(color: Theme.of(context).colorScheme.primary),
      ),
      trailing: Icon(
        Icons.keyboard_capslock,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () {
        print('tapped');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      left: false,
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildHistoryCardWidget(context, 'Pressure'),
            ],
          ),
        ),
      ),
    );
  }
}
