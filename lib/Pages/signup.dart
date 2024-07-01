import 'package:crud_project/Pages/home.dart';
import 'package:crud_project/Widget/button.dart';
import 'package:flutter/material.dart';


import '../Services/authentication.dart';
import '../Widget/snackbar.dart';
import '../Widget/text_field.dart';

import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height / 2.8,
              child: Image.asset('assets/login.jpg'),
            ),
            TextFieldInput(
                icon: Icons.person,
                textEditingController: nameController,
                hintText: 'Enter your name',
                textInputType: TextInputType.text),
            TextFieldInput(
                icon: Icons.email,
                textEditingController: emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.text),
            TextFieldInput(
              icon: Icons.lock,
              textEditingController: passwordController,
              hintText: 'Enter your passord',
              textInputType: TextInputType.text,
              isPass: true,
            ),
            MyButtons(onTap: signupUser, text: "Sign Up"),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    " Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
// import 'package:crud_project/Widget/button.dart';
// import 'package:flutter/material.dart';
// import '../Services/authentication.dart';
// import '../Widget/snackbar.dart';
// import '../Widget/text_field.dart';
// import 'login.dart';
// import 'home.dart'; // Make sure to import the Home screen

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isLoading = false;

//   void signupUser() async {
//     setState(() {
//       isLoading = true;
//     });

//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String name = nameController.text.trim();

//     String res = await AuthMethod().signInWithGoogle(
//       // email: email,
//       // password: password,
//       // name: name,
//     );

//     if (res == "success") {
//       setState(() {
//         isLoading = false;
//       });

//       // After signup, fetch the current user's ID and navigate to Home screen.
//       String userId = AuthMethod().getCurrentUser()!.uid;

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => Home(userId: userId),
//         ),
//       );
//     } else {
//       setState(() {
//         isLoading = false;
//       });

//       showSnackBar(context, res);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: SizedBox(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: height / 2.8,
//                 child: Image.asset('assets/login.jpg'),
//               ),
//               TextFieldInput(
//                 icon: Icons.person,
//                 textEditingController: nameController,
//                 hintText: 'Enter your name',
//                 textInputType: TextInputType.text,
//               ),
//               TextFieldInput(
//                 icon: Icons.email,
//                 textEditingController: emailController,
//                 hintText: 'Enter your email',
//                 textInputType: TextInputType.emailAddress,
//               ),
//               TextFieldInput(
//                 icon: Icons.lock,
//                 textEditingController: passwordController,
//                 hintText: 'Enter your password',
//                 textInputType: TextInputType.text,
//                 isPass: true,
//               ),
//               MyButtons(onTap: signupUser, text: "Sign Up"),
//               const SizedBox(height: 50),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have an account?"),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => const LoginScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       " Login",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
