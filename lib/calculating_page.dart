import 'dart:math' as math;

import 'package:flutter/material.dart';

class CalculatingPage extends StatefulWidget {
  const CalculatingPage({Key? key}) : super(key: key);

  @override
  State<CalculatingPage> createState() => _CalculatingPageState();
}

class _CalculatingPageState extends State<CalculatingPage> {
  final TextEditingController variableQ = TextEditingController();
  final TextEditingController variableX = TextEditingController();
  final TextEditingController variableY = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final double staticVariable = 7.95775;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Align(
          alignment: AlignmentDirectional.topStart,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text('الرقم الثابت: $staticVariable'),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: variableQ,
                      validator: validator,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(label: Text('زاوية المسنن')),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: variableX,
                      validator: validator,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(label: Text('رقم الموديل')),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: validator,
                      keyboardType: TextInputType.number,
                      controller: variableY,
                      decoration: const InputDecoration(label: Text('رقم مفروض')),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if(isPressed)
                    Row(

                      children: [
                        const Text('الناتج:  '),
                        Text(
                            '${calculateMathEquation().toStringAsFixed(5)}'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Text('احسب'),
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              isPressed = true;
              setState(() {});
            }
          },
        ),
      ),
    );
  }

  String? validator(String? value) {
    return value!.isNotEmpty ? null : 'اكتب الرقم المطلوب';
  }
  double calculateMathEquation(){
    return
      ((int.tryParse(variableX.text) ?? 0) * (int.tryParse(variableY.text) ?? 0)) / (staticVariable * math.sin((int.tryParse(variableQ.text)??1 )* (math.pi / 180)));
  }
}
