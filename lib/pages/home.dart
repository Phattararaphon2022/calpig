// ignore_for_file: avoid_prin, use_build_context_synchronously, prefer_const_constructors
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
  bool status = false;
  String type = "";
  int quantity = 0;
  int caltotal = 0;
  List data = [];
  var select = {};
  List dataAdd = [];
  List meat = [
    {
      'no': '1',
      'name': 'หมูสามชั้น',
      'description': 'หมูสามชั้น 3 ชิ้น 100 กรัม ให้พลังงาน 581 Kcal',
      'image': 'assets/images/porkbelly.png',
      'cal': 581,
      'num': 0
    },
    {
      'no': '2',
      'name': 'เนื้อหมูสไลด์',
      'description': 'เนื้อหมูสไลด์ 3 ชิ้น ให้พลังงาน 175 Kcal',
      'image': 'assets/images/slicedpork.png',
      'cal': 175,
      'num': 0
    },
    {
      'no': '3',
      'name': 'เนื้อวัว',
      'description': 'เนื้อวัว 100 กรัม ให้พลังงาน 134 Kcal',
      'image': 'assets/images/beef.png',
      'cal': 134,
      'num': 0
    },
    {
      'no': '4',
      'name': 'เนื้อวัวสไลด์',
      'description': 'เนื้อวัวสไลด์ 3 ชิ้น 100 กรัม ให้พลังงาน 154 Kcal',
      'image': 'assets/images/beefslices.png',
      'cal': 154,
      'num': 0
    },
    {
      'no': '5',
      'name': 'เนื้อไก่',
      'description': 'เนื้อไก่ 2 ชิ้น ให้พลังงาน 69 Kcal',
      'image': 'assets/images/chickenmeat.png',
      'cal': 69,
      'num': 0
    },
  ];
  List seafood = [
    {
      'no': '1',
      'name': 'กุ้ง',
      'description': 'กุ้ง 3 ชิ้น ให้พลังงาน 55 Kcal',
      'image': 'assets/images/shrimp.png',
      'cal': 55,
      'num': 0
    },
  ];
  List food = [
    {
      'no': '1',
      'name': 'เต้าหู้ชีส',
      'description': 'เต้าหู้ชีส 100 กรัม ให้พลังงาน 280 Kcal',
      'image': 'assets/images/cheeseTofu.png',
      'cal': 280,
      'num': 0
    }
  ];
  List vegetable = [
    {
      'no': '1',
      'name': 'แครอท',
      'description': 'แครอท 100 กรัม ให้พลังงาน 46 Kcal',
      'image': 'assets/images/carrot.png',
      'cal': 46,
      'num': 0
    },
    {
      'no': '2',
      'name': 'ผักกวางตุ้ง',
      'description': 'ผักกวางตุ้ง 100 กรัม ให้พลังงาน 13 Kcal',
      'image': 'assets/images/bokchoy.png',
      'cal': 13,
      'num': 0
    },
    {
      'no': '3',
      'name': 'เห็ดเข็มทอง',
      'description': 'เห็ดเข็มทอง 100 กรัม ให้พลังงาน 37 Kcal',
      'image': 'assets/images/goldenneedlemushroom.png',
      'cal': 37,
      'num': 0
    },
    {
      'no': '4',
      'name': 'ผักกาดขาว',
      'description': 'ผักกาดขาว 100 กรัม ให้พลังงาน 12 Kcal',
      'image': 'assets/images/chinesecabbage.png',
      'cal': 12,
      'num': 0
    },
    {
      'no': '5',
      'name': 'ข้าวโพด ',
      'description': 'ข้าวโพด 100 กรัม ให้พลังงาน 33 Kcal',
      'image': 'assets/images/babycorn.png',
      'cal': 33,
      'num': 0
    },
  ];
  @override
  initState() {
    super.initState();
    // getProfile();
  }

  Future<bool> getProfile() async {
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: FutureBuilder(
      future: getProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/backgroup.png',
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.03, left: 10),
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
                      padding: EdgeInsets.only(top: height * 0.01),
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
                    padding: EdgeInsets.only(top: height * 0.35),
                    child: Image.asset('assets/images/Asset_1.png',
                        height: 80, fit: BoxFit.fill),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            !status
                                ? PopupMenuButton<int>(
                                    child: Icon(
                                      Icons.list,
                                      color: Colors.white,
                                    ),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem<int>(
                                            value: 1,
                                            child: Text("เนื้อสัตว์")),
                                        PopupMenuItem<int>(
                                            value: 2, child: Text("อาหารทะเล")),
                                        PopupMenuItem<int>(
                                            value: 3,
                                            child: Text("อาหารทรงเครื่อง")),
                                        PopupMenuItem<int>(
                                            value: 4, child: Text("ผักสด")),
                                      ];
                                    },
                                    onSelected: (value) {
                                      print(value);
                                      setState(() {
                                        if (value == 1) {
                                          data = meat;
                                        }
                                        if (value == 2) {
                                          data = seafood;
                                        }
                                        if (value == 3) {
                                          data = food;
                                        }
                                        if (value == 4) {
                                          data = vegetable;
                                        }
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        status = false;
                                        select = {};
                                      });
                                    },
                                  ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: height,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Spacer(),
                                                Spacer(),
                                                Text(
                                                  "รายการอาหารที่เพิ่มลงในตะกร้า",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 18),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    setState(() {
                                                      // quantity++;
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Center(
                                              child: Container(
                                                height: height * 0.49,
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.center,
                                                  // mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    for (var i in dataAdd)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    "${i['no']}."),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    i['image'],
                                                                    width:
                                                                        width *
                                                                            0.15,
                                                                  ),
                                                                ),
                                                                Text(i['name']),
                                                              ],
                                                            ),
                                                            Text(
                                                                "จำนวน ${i['num']} ถาด")
                                                          ],
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                              },
                              child: Image.asset(
                                'assets/images/icon_1.png',
                                width: 18,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  !status
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Container(
                                height: height * 0.295,
                                width: width * 0.95,
                                child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: <Widget>[
                                      Wrap(
                                        spacing:
                                            8.0, // gap between adjacent chips
                                        runSpacing: 8.0, // gap between lines
                                        children: <Widget>[
                                          for (var i in data)
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  print(i);
                                                  status = true;
                                                  select = i;
                                                  select['num'] = 0;
                                                });
                                              },
                                              child: Container(
                                                width: width * 0.3,
                                                height: 100,
                                                color: Colors.white,
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Image.asset(
                                                        i['image'],
                                                        width: width * 0.2,
                                                      ),
                                                      Text(
                                                        i['name'],
                                                        style: TextStyle(
                                                            // color: Colors.red,
                                                            fontSize: 14),
                                                      ),
                                                    ]),
                                              ),
                                            )
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: width * 0.9,
                          // height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(children: [
                            Row(
                              children: [
                                // Text("${select['no']}."),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 5),
                                  child: Image.asset(
                                    select['image'],
                                    width: width * 0.15,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    select['name'],
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "รายละเอียด",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Text(
                              select['description'],
                              style: TextStyle(fontSize: 14),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (select['num'] > 0) {
                                        select['num']--;
                                      }
                                    });
                                  },
                                ),
                                Text(select['num'].toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      // quantity++;
                                      select['num']++;
                                    });
                                  },
                                ),
                                Text("= "),
                                Text((select['num'] * select['cal']).toString())
                              ],
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  dataAdd.add({
                                    'no': dataAdd.length + 1,
                                    'name': select['name'],
                                    'description': select['description'],
                                    'image': select['image'],
                                    'cal': select['cal'],
                                    'num': select['num'],
                                  });
                                  int cal = select['cal'] * select['num'];
                                  caltotal += cal;
                                  print(select['cal'] * select['num']);
                                  select['num'] = 0;
                                });
                              },
                              child: Text(
                                'เพิ่มลงในตะกร้า',
                                style: TextStyle(color: Colors.red),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                side: BorderSide(width: 1, color: Colors.red),
                              ),
                            )
                          ]),
                        ),
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
