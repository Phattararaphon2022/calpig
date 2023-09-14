// ignore_for_file: avoid_prin, use_build_context_synchronously
import 'package:calpig/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleSignInAccount? user;
  int caltotal = 10;
  List data = [];
  List ttt = [
    "aa",
    "bb",
    "cc",
  ];
  @override
  initState() {
    super.initState();
    // getProfile();
  }

  Future<bool> getProfile() async {
    print("kkkk");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      user = await googleSignIn.signInSilently();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double widths = MediaQuery.of(context).size.width;
    double heights = MediaQuery.of(context).size.height;
    return Scaffold(
        body: FutureBuilder(
      future: getProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/backgroup.png',
                width: widths,
                height: heights,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: heights * 0.03, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22, // Image radius
                              backgroundImage:
                                  NetworkImage('${user?.photoUrl}' ""),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('${user?.displayName}'),
                            )
                          ],
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.signOut),
                          tooltip: 'Sign out',
                          onPressed: () {
                            setState(() async {
                              final GoogleSignIn googleSignIn = GoogleSignIn();
                              await googleSignIn.isSignedIn();
                              await googleSignIn.disconnect();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyApp()),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: heights * 0.01),
                      child: const Text("Calories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                    ),
                  ),
                  Center(
                    child: Text(caltotal.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: heights * 0.45),
                    child: Image.asset('assets/images/Asset_1.png',
                        height: 80, fit: BoxFit.fill),
                  ),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          data.add(GestureDetector(
                            onTap: () {
                              print("Test");
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text((data.length + 1).toString()),
                            ),
                          ));
                        });
                      },
                      child: const Text("Add")),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                    child: MasonryGridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return data[index];
                      },
                    ),
                  ))
                ],
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
