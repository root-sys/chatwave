import 'package:chatwave/Screens/Login%20Screen.dart';
import 'package:flutter/material.dart';
import 'registration screen.dart';
import '../Components/FieldWidget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String id = 'WelcomeScreen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late CurvedAnimation animation;
  late AnimationController controller;
  @override
  void initState() {
 controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
   controller.forward();
   controller.addListener(() {
     setState(() {

     });
     print(animation.value);
   });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(

              children: [
                Hero(
                  tag: 'logo',
                  child: Container(

                    child: Image.asset('images/monster.png'),
                    height: 90,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextLiquidFill(
boxHeight: 180.0,
                    boxWidth: 240,
                    text: 'CHAT WAVE',
                    waveColor: Colors.green,
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],

            ),

            FieldWidget('LOG IN', Colors.lightBlueAccent,(){Navigator.pushNamed(context, LoginScreen.id);}),
            FieldWidget('REGISTER', Colors.blueAccent,(){Navigator.pushNamed(context, RegistrationScreen.id);})
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 18.0),
            //   child: Material(
            //     elevation: 5.0,
            //     color: Colors.blueAccent,
            //     borderRadius: BorderRadius.circular(50.0),
            //     child: TextButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, RegistrationScreen.id);
            //       },
            //       child: Text(
            //           'REGISTER',
            //         style: TextStyle(
            //           color: Colors.white
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}


