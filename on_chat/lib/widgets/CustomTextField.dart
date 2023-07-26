import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({ this.obscureText=false  ,required this.lableText , this.onChanged ,});
  String? lableText;
  Function(String)? onChanged;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data)
      {
        if( data!.isEmpty ){return 'value is wrong';}
      },
      onChanged:onChanged,
      decoration: InputDecoration(
        labelText: lableText,
     
      ),
    );
  }
}
