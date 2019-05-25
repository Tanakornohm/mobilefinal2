import 'package:flutter/material.dart';
import 'package:mobilefinal2/interface/login_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // is not restarted.
        brightness:  Brightness.dark,
      ),
      //home: MyHomePage(),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        // "/form_screen": (context) => form_screen(),
        },
    );
  }
}
