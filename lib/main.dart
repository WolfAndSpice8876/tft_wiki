import 'package:flutter/material.dart';
import 'package:lol/pages/loading_page.dart';
import 'package:lol/normal/size.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'LoL App',
        theme: ThemeData(
          fontFamily: "roboto_bold"
        ),
        home: const Home(),
        debugShowCheckedModeBanner: false,
        builder: (context, child){
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!
          );
        }
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setSize(MediaQuery.of(context).size.width);

    return LoadingPage();
  }
}

