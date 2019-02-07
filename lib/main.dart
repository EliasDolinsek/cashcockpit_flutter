import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/sign_in_option_page.dart';
import './pages/sign_in_page.dart';
import './pages/sign_up_page.dart';

void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new CashCockpit());
  });
}

class CashCockpit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepPurpleAccent
      ),
      routes: {
        "/sign_in_options":(BuildContext context) => SignInOptionPage(),
        "/sign_in":(BuildContext context) => SignInPage(),
        "/sign_up":(BuildContext context) => SignUpPage(),
      },
      home: SignInOptionPage(),
    );
  }
}
