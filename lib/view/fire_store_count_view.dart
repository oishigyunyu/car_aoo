import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class FireStoreView extends StatefulWidget {
  const FireStoreView({super.key});

  @override
  State<FireStoreView> createState() => _FireStoreViewState();
}

class _FireStoreViewState extends State<FireStoreView> {
  DateTime _date = DateTime.now();
  final List<dynamic> _datas = [];

  Future<void> _postData() async {
    final db = FirebaseFirestore.instance;
    final collectionRef = db.collection('users');
    await collectionRef.doc('hogehoge').set({
      'name':'Mike',
      'age': 23,
      'married': false,
      'children': [],
      'createdAt': DateTime.now()
    });
  }

  Future<void> _getData() async {
    final db = FirebaseFirestore.instance;
    final collectionRef = db.collection('users');
    final doc = await collectionRef.doc('hogehoge').get();
    final data = doc.data();
    if (data != null) {
      setState(() {
        _datas.add(data);
      });
    }
  }

  Future<void> _getAll() async {
    final db = FirebaseFirestore.instance;
    final collectionRef = db.collection('users');
    final collection = await collectionRef.get();
    final docs = collection.docs;
    if (docs.isNotEmpty) {
      setState(() {
        for (var doc in docs) {
          _datas.add(doc.data());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          color: Theme.of(context).colorScheme.background,
          child: Card(
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2023, 1, 1),
                      maxTime: DateTime(2099, 12, 31),
                      onChanged: (date) {
                        _date = date;
                        print('change $date');
                      },
                      onConfirm: (date) {
                        _date = date;
                        print('confirm $date');
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.jp,
                    );
                  },
                  child: Text(
                    '生年月日を選択',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.apply(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                Text(
                  '$_date',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.apply(color: Theme.of(context).colorScheme.onPrimary),
                ),
                SizedBox(height: 12.0,),
                FilledButton(
                  onPressed: (){
                    print('tapped: $_date');
                    _postData();
                  },
                  child: const Text('送信'),
                ),
                SizedBox(height: 12.0,),
                FilledButton(
                  onPressed: (){
                    print('tapped getall');
                    _postData();
                  },
                  child: const Text('全件取得'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
