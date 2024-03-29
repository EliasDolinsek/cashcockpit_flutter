import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/sing_up_toolbox.dart';
import '../../tools/auth.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(padding: EdgeInsets.all(16.0), child: _SignUpInputs()),
    );
  }
}

class _SignUpInputs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpInputsState();
  }
}

class _SignUpInputsState extends State<_SignUpInputs> {
  final _key = GlobalKey<FormState>();
  bool _agreedToPrivacyPolicy = false, _signUpProcessActive = false;
  String _email, _password, _passwordConformation;
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: ListView(
        children: <Widget>[
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "E-Mail"),
            validator: (value) {
              if (!RegExp(
                      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                  .hasMatch(value)) {
                return "Enter a valid E-Mail address";
              }
            },
            onSaved: (value) {
              _email = value;
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Password"),
            validator: (value) {
              if (value.length < 6) {
                return "Password must have at lest 6 characters";
              }
            },
            onSaved: (value) {
              _password = value;
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Confirm Password"),
            validator: (value) {
              _key.currentState.save();
              if (_passwordConformation != _password) {
                return "Passwords don't match";
              }
            },
            onSaved: (value) {
              _passwordConformation = value;
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          CheckboxListTile(
            value: _agreedToPrivacyPolicy,
            title: Text(
              "I have read and agree to CashCockpits Terms of Use and Privacy Policy",
              style: TextStyle(fontFamily: "Roboto", fontSize: 14),
            ),
            onChanged: (value) {
              setState(() {
                _agreedToPrivacyPolicy = value;
              });
            },
          ),
          Visibility(
              visible: _errorMessage != null,
              maintainSize: false,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _errorMessage == null ? "" : _errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              )),
          RaisedButton(
            child: Text("SIGN UP"),
            onPressed: _agreedToPrivacyPolicy && !_signUpProcessActive
                ? () {
                    if(_key.currentState.validate()){
                      _key.currentState.save();
                      _signUpUser();
                      setState(() {
                        _signUpProcessActive = true;
                      });
                    }
                  }
                : null,
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }

  void _signUpUser() async {
    try {
      await Auth().signUpUser(_email, _password);
      Navigator.pushReplacementNamed(context, "/settings_setup");
    } catch (e) {
      if (e is PlatformException) {
        setState(() {
          _errorMessage = SignUpToolbox.getErrorMessageOfErrorCode(e.code);
          _signUpProcessActive = false;
        });
      }
    }
  }
}