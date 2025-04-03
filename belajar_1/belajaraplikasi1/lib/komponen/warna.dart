import 'package:flutter/material.dart';

class WidgedWarna extends StatelessWidget {
  const WidgedWarna({Key? key, required this.teks, required this.warna})
    : super(key: key);

  final String teks;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: warna, child: Text(teks));
  }
}
