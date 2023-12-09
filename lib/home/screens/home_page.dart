import 'package:flutter/material.dart';

class HomeFeedsPage extends StatefulWidget {
  const HomeFeedsPage({Key? key}) : super(key: key);

  @override
  _HomeFeedsPageState createState() => _HomeFeedsPageState();
}

class _HomeFeedsPageState extends State<HomeFeedsPage> {
  late Future<List<dynamic>> Function() fetchDataFunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Text("placeholder")
          ],
          )
        );
  }
}
