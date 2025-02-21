import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String texto;
  const TextLabel({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(texto,
          style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 20, 19, 20))),
    );
  }
}