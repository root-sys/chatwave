import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  final String text;
  final MaterialAccentColor colour;
  final VoidCallback onPressed;
  const FieldWidget( this.text,this.colour,@required this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Material(
        elevation: 5.0,
        color:this.colour,
        borderRadius: BorderRadius.circular(50.0),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            this.text,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}