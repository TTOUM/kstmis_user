import 'package:flutter/material.dart';

import '../signin.dart';
import '../widgets.dart';

class SignInMobile extends StatefulWidget {
  @override
  _SignInMobileState createState() => _SignInMobileState();
}

class _SignInMobileState extends State<SignInMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/kst.png'),width: 100,),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Login Panel',
                  style: TextStyle(fontSize: 25, color: Color(0xfF004123)),

                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.all(20),
                  child: Container(
                    margin:
                    EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50),
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
                        Widgets().checkBox(checked: checkedRemember,onChange: (value){
                          setState(() {
                            checkedRemember=value;
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
      ),

    );
  }
}
