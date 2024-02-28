import 'package:flutter/material.dart';
import 'package:news/screens/home_screen.dart';
import 'package:news/screens/login.dart';
void main(){
  runApp(const News());
}
class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
