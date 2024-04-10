import 'package:flutter/material.dart';
import 'app_bar.dart'; 
import 'main_content_area.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(context),
      body: const MainContentArea(),
    );
  }
}
