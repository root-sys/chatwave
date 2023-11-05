import 'package:chatwave/Screens/chat%20screen.dart';
import 'package:flutter/material.dart';
import '../Components/FieldWidget.dart';
import '../Components/Styling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
static const String id = 'LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
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
                decoration: formstyling.copyWith(
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
password  = value;
                },
                decoration: formstyling.copyWith(
                  hintText: 'Enter Your Password'
                )
              ),
              SizedBox(
                height: 40.0,
              ),
              FieldWidget('LOG IN', Colors.lightBlueAccent,()async{
               setState((){
                 isLoading = true;
               });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {

                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState((){
                    isLoading = false;
                  });
                }
                catch(e){
                  print(e);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
