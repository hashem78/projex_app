import 'package:flutter/material.dart';
import 'package:projex_app/screens/home/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const PDrawer(),
    );
  }
}
