import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  Color color = Colors.red;
  List items = List.generate(1000, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Iso
        Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        goodPerformance();
                      },
                      child: const Text('goodPerformance'),
                    ))),
            Expanded(
                child: SizedBox(
                    height: 70,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        badPerformance();
                      },
                      child: const Text('badPerformance'),
                    ))),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        const CircularProgressIndicator(),
      ],
    ));
  }


  Future<double> goodPerformance() async {
    return await compute<List, double>(goodPerformanceTask, [60000000, 50]);
  }

  Future<double> goodPerformanceTask(List items) async {
    double sum = 0;
    for (int i = 0; i < items[0]; i++) {
      sum = sum + i * items[1];
    }
    debugPrint('$sum');
    return sum;
  }

  badPerformance({List items = const [60000000, 50]}) async {
    double sum = 0;
    for (int i = 0; i < items[0]; i++) {
      sum = sum + i * items[1];
    }
    debugPrint('$sum');
    return sum;
  }
}
