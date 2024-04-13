import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todonew/Const/const.dart';
import 'package:todonew/Views/Todo/index.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor).copyWith(
          background: primaryColor,
        ),
      ),
      home: const ToDos(),
    );
  }
}
