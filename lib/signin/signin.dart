import 'package:flutter/material.dart';
import 'package:kstmis/home/home.dart';
import 'package:kstmis/signin/sreens/signin_tablet.dart';
import 'package:kstmis/utils/navigator.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'sreens/signin_mobile.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

final formKey = GlobalKey<FormState>();
bool checkedRemember = false;
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if(sizingInformation.deviceScreenType==DeviceScreenType.mobile){
              return SignInMobile();
            }
            if(sizingInformation.deviceScreenType==DeviceScreenType.tablet){
              return SignInTablet();
            }
            return Container(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        color: Color(0xfF004123),
                        child: _leftSide(),
                      )),
                  Expanded(
                      child: Container(
                        child: _rightSide(),
                      ))
                ],
              ),
            );
          },
        ),
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
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Panel',
              style: TextStyle(fontSize: 25, color: Color(0xfF004123)),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 1,
              margin: EdgeInsets.all(20),
              child: Container(
                margin:
                    EdgeInsets.only(left: 100, right: 100, top: 50, bottom: 50),
                child: Column(
                  children: [
                    textInput(
                      label: 'Username',
                      hint: 'Username',
                      secure: false,
                      controller: usernameController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    textInput(
                      label: 'Password',
                      hint: 'Password',
                      secure: true,
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _checkBox(),
                    _loginButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginButton() {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.only(top: 20, bottom: 20),
        color: Colors.blueAccent,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          // if (formKey.currentState.validate()) {
          //   print('Click me!!');
          // }
          Navigators().navigatorPushAndRemove(context, Home());
        },
      ),
    );
  }

  _checkBox() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: checkedRemember,
            onChanged: (value) {
              setState(() {
                checkedRemember = value;
              });
            },
          ),
          Text('Remember me')
        ],
      ),
    );
  }

  textInput(
      {String label,
      String hint,
      TextEditingController controller,
      bool secure}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: secure,
          decoration: InputDecoration(
            focusColor: Colors.black,
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          validator: (value) =>
              value.isEmpty || value == "" ? 'Please fill data' : '',
        ),
      ],
    );
  }
}
