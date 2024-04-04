// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison, use_build_context_synchronously

import 'package:calpig/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double widths = MediaQuery.of(context).size.width;
    double heights = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/backgroup.png',
          width: widths,
          height: heights,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            // ButtonAction(heights * 0.65, FontAwesomeIcons.facebook,
            //     Colors.blue[600], "Facebook Login"),
            ButtonAction(20.0, FontAwesomeIcons.googlePlus, Colors.red[600],
                "Google Login"),
          ],
        ),
      ],
    ));
  }

  Widget ButtonAction(top, icon, iconcolor, text) {
    return GestureDetector(
      onTap: () {
        print(text);
        if (text == "Google Login") {
          SingINWithGoogle();
        }
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Home()),
        // );
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: top,
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: FaIcon(
                    icon,
                    size: 35,
                    color: iconcolor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(text,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> SingINWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? user = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await user!.authentication;
    print(user);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
    // await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
    //     idToken: userAuth.idToken, accessToken: userAuth.accessToken));
    // await Firebase.initializeApp().then((value) async {
    //   await _googleSignIn.signIn().then((value) {
    //     print("Login With gmail Success");
    //   });
    // });
  }
}
