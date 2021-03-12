import 'package:flutter/material.dart';

import '../signin.dart';
import '../widgets.dart';

class SignInTablet extends StatefulWidget {
  @override
  _SignInTabletState createState() => _SignInTabletState();
}

class _SignInTabletState extends State<SignInTablet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            color: Color(0xfF004123),
            child: _leftSide(),
          ),
          Expanded(
              child: Container(
            child: _rightSide(),
          ))
        ],
      ),
    );
  }

  _leftSide() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/kst.png'),
            width: 200,
          ),
        ],
      ),
    );
  }

  _rightSide() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Card(
                elevation: 1,
                margin: EdgeInsets.all(20),
                child: Container(
                  margin:
                      EdgeInsets.only(left: 100, right: 100, top: 50, bottom: 50),
                  child: Column(
                    children: [
                      Widgets().textInput(
                        label: 'Username',
                        hint: 'Username',
                        secure: false,
                        controller: usernameController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Widgets().textInput(
                        label: 'Password',
                        hint: 'Password',
                        secure: true,
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Widgets().checkBox(
                          checked: checkedRemember,
                          onChange: (value) {
                            setState(() {
                              checkedRemember = value;
                            });
                          }),
                      Widgets().loginButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
