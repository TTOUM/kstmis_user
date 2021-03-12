import 'package:flutter/material.dart';

import 'signin.dart';
class Widgets{
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
  checkBox({bool checked , ValueChanged<bool> onChange}) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: onChange
          ),
          Text('Remember me')
        ],
      ),
    );
  }

  loginButton() {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.only(top: 15, bottom: 15),
        color: Colors.blueAccent,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (formKey.currentState.validate()) {
            print('Click me!!');
          }
        },
      ),
    );
  }
}