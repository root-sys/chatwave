import 'dart:ffi';

import 'package:chatwave/Screens/Login%20Screen.dart';
import 'package:flutter/material.dart';
import '../Components/FieldWidget.dart';
import '../Components/Styling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login Screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
static const String id = 'RegistrationScreen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
final _auth = FirebaseAuth.instance;
late  String email;
 late String password;
 bool  isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(tag: 'logo', child: Container(
                child: Image.asset('images/monster.png'
                ),
                height: 90.0,
              )),
              SizedBox(
                height: 40.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.black54
                ),
                onChanged: (value){
               email = value;
                },
              decoration:   formstyling.copyWith(
                  hintText: 'Enter Your Email'
              )
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(

                    color: Colors.black54
                ),
                onChanged: (value){
                  password = value;
                },
                decoration:  formstyling.copyWith(
                  hintText: 'Enter Your Password'
              )
              ),
              SizedBox(
                height: 40.0,
              ),
              FieldWidget('REGISTER', Colors.blueAccent,
                     ()async{
                       setState((){
                         isLoading = true;
                       });
                try{
               final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
               if(newuser != null){
                 Navigator.pushNamed(context,LoginScreen.id);
               }
               setState((){
                 isLoading = false;
               });
              }
                catch(e){
                  print(e);
                }
              }
     )


            ],
          ),
        ),
      ),
    );
  }
}
