import 'package:flutter/material.dart';
import'Screens/Welcome Screen.dart';
import'Screens/Login Screen.dart';
import 'Screens/registration screen.dart';
import'Screens/chat screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(

        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black54
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        ChatScreen.id:(context)=>ChatScreen()


      },
    );
  }
}
