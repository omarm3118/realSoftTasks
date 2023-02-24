import 'package:flutter/material.dart';

import 'calculating_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/background.jpeg', fit: BoxFit.cover)),
        floatingActionButton: FloatingActionButton(
          child: const Text('ابدأ'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CalculatingPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
