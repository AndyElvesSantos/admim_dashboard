import 'package:admin_dashboard/atendidos/atendidos.page.dart';
import 'package:flutter/material.dart';

import 'home/home.page.dart';
import 'para_atender/para_atender.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner:false,
      initialRoute: "/",
      home: const HomePage(),
    );
  }
}
