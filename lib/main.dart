// import 'package:crud_project/Pages/MyRegister.dart';
import 'package:crud_project/pages/home.dart';
// import 'package:crud_project/services/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:crud_project/firebase_options.dart';
import 'package:crud_project/services/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// Import your signup page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        // Define your app's theme here
      ),
      // Use a navigator observer to handle route changes if needed
      navigatorObservers: [],
      initialRoute: '/', // Set the initial route to splash screen
      routes: {
        '/': (context) => SplashScreen(), // SplashScreen as the initial screen
        // '/login': (context) => MyLogin(),
        // '/signup': (context) => MyRegister(), // Add route for SignupPage
        '/home': (context) => Home(),
      },
    );
  }
}
