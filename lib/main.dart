import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/providers/cityProvider.dart';
import 'package:tango/screens/Add_Screen.dart';
//import 'package:tango/providers/groupProvider.dart';
import 'package:tango/screens/chat_screen.dart';
import 'package:tango/screens/home.dart';
import 'package:tango/screens/landingScreen.dart';
import 'package:tango/screens/login_screen.dart';
import 'package:tango/screens/registration_screen.dart';
import 'package:tango/screens/temp.dart';
import 'package:tango/screens/welcome_screen.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TangoApp());
}

class TangoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: [
       // ChangeNotifierProvider(create: (context)=> GroupProvider()),
        ChangeNotifierProvider(create: (context)=> CityProvider()),
      ],
     child:
    MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark().copyWith(
        //   textTheme: TextTheme(
        //     bodyText1: TextStyle(color: Colors.black54),
        //   ),
        // ),

        //initialRoute: 'chatscreen',
         initialRoute: 'welcomescreen',
        routes: {
          'welcomescreen': (context)=> WelcomeScreen(),
          'loginscreen': (context)=> LoginScreen(),
          'registrationscreen': (context)=> RegistrationScreen(),
          'chatscreen': (context)=> ChatScreen(),
          'homescreen': (context)=> HomeScreen(),
          'landingscreen':(context)=> LandingScreen(),
          'addscreen':(context)=>AddGroup(),
          'profilescreen':(context)=> ProfileScreen()
        },
     ),
    );
  }
}




