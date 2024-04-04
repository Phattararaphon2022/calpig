import 'dart:async';
import 'package:calpig/pages/home.dart';
import 'package:calpig/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late Stream dataranking;
  List<String> imageUrls = [
    'https://picsum.photos/200/300?image=0',
    'https://picsum.photos/200/300?image=1',
    'https://picsum.photos/200/300?image=2',
    'https://picsum.photos/200/300?image=3',
    'https://picsum.photos/200/300?image=4',
    'https://picsum.photos/200/300?image=5',
    'https://picsum.photos/200/300?image=6',
    'https://picsum.photos/200/300?image=7',
    'https://picsum.photos/200/300?image=8',
    'https://picsum.photos/200/300?image=9',
    'https://picsum.photos/200/300?image=10',
    'https://picsum.photos/200/300?image=11',
    'https://picsum.photos/200/300?image=12',
    'https://picsum.photos/200/300?image=13',
    'https://picsum.photos/200/300?image=14',
    'https://picsum.photos/200/300?image=15',
  ];

  List<String> shuffledImages = [];

  int _timerValue = 0;
  late Timer _timer;
  bool startgame = false;

  Set<int> tappedIndexes = Set();
  GoogleSignInAccount? user;
  testgetData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get a reference to the collection
    CollectionReference collection = firestore.collection('ranking');

    // Get documents from the collection
    QuerySnapshot querySnapshot = await collection.orderBy('time').get();

    // Process the data
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      print(document.data());
    });
    print(querySnapshot.docs[0]['time']);
  }

  Future<bool> getProfile() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    if (await googleSignIn.isSignedIn()) {
      print("GGGGGGGGGGGGGGGGGGGGGGGGGGG");
      // await googleSignIn.isSignedIn();
      // await googleSignIn.disconnect();
      user = await googleSignIn.signInSilently();
      print(user);
      return true;
    } else {
      print("FFFFFFFFFFFFFFFFFFFFFFFF");
      return false;
    }
  }

  Future<void> insertOrUpdateData(int newScore) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference itemsCollection = firestore.collection('ranking');

      // Check if the document with the given itemId exists
      DocumentSnapshot documentSnapshot =
          await itemsCollection.doc(user?.id).get();
      if (documentSnapshot.exists) {
        // Document exists, update the score
        if (documentSnapshot.get('time') > newScore &&
            user?.displayName != null) {
          await itemsCollection
              .doc(user?.id)
              .update({'name': user?.displayName, 'time': newScore});
          print('Document updated successfully');
        }
      } else if (user?.displayName != null) {
        // Document doesn't exist, insert a new document
        await itemsCollection
            .doc(user?.id)
            .set({'name': user?.displayName, 'time': newScore});
        print('Document inserted successfully');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // _initializeGame();
    // _startTimer();
    testgetData();
    getProfile();
  }

  void _initializeGame() {
    List<String> selectedImages = getRandomImages(imageUrls, 6);
    shuffledImages = List.from(selectedImages)..addAll(selectedImages);
    shuffledImages.shuffle();
  }

  bool _isMatch(List<String> selectedImages) {
    return selectedImages[0] == selectedImages[1];
  }

  List<String> getRandomImages(List<String> imageUrls, int count) {
    List<String> selectedImages = [];
    Random random = Random();

    // Shuffle the original list to get a random order
    List<String> shuffledList = List.from(imageUrls)..shuffle();

    // Select the first 'count' items from the shuffled list
    for (int i = 0; i < count; i++) {
      selectedImages.add(shuffledList[i]);
    }

    return selectedImages;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timerValue++;
      });
    });
    setState(() {
      startgame = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Home()))),
        title: Text('เกม จับคู่ภาพ'),
        centerTitle: true,
      ),
      body: !startgame
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Add code to start the game here
                      print('Game started!');
                      _initializeGame();
                      _startTimer();
                      setState(() {
                        startgame = true;
                      });
                    },
                    child: Text('Start Game'),
                  ),
                  SizedBox(
                      height:
                          20), // Add some space between button and description
                  Text(
                    'จับคู่ภาพ ให้ไวที่สุด',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: shuffledImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _onImageTap(index);
                  },
                  child: ColorFiltered(
                    colorFilter: tappedIndexes.contains(index)
                        ? ColorFilter.mode(
                            Colors.blue.withOpacity(0.5),
                            BlendMode.srcATop,
                          )
                        : ColorFilter.mode(
                            Colors.white.withOpacity(0),
                            BlendMode.srcATop,
                          ),
                    child: Card(
                      color: Colors.white, // Set card background color
                      elevation: 5.0, // Add elevation for a shadow effect
                      child: Image.network(
                        shuffledImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: startgame
          ? BottomAppBar(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Time: $_timerValue seconds'),
              ),
            )
          : null,
    );
  }

  void _onImageTap(int index) {
    setState(() {
      if (tappedIndexes.contains(index)) {
        // If already tapped, unselect it
        tappedIndexes.remove(index);
      } else {
        // If not tapped, select it
        tappedIndexes.add(index);
      }

      if (tappedIndexes.length == 2) {
        List<String> selectedImages =
            tappedIndexes.map((index) => shuffledImages[index]).toList();

        if (_isMatch(selectedImages)) {
          // Matched, remove the images
          for (int i in tappedIndexes) {
            shuffledImages[i] =
                'https://raw.githubusercontent.com/Phattararaphon2022/calpig/Image/BGW.png'; // Replace with an empty string or any other placeholder
          }
          if (shuffledImages.every((element) =>
              element ==
              'https://raw.githubusercontent.com/Phattararaphon2022/calpig/Image/BGW.png')) {
            // All images matched, stop the timer or handle game end
            _timer.cancel();
            _showGameEndDialog();
            insertOrUpdateData(_timerValue);
            print(user);
          }
        }

        // Reset selected indexes
        tappedIndexes.clear();
      }
    });
  }

  void _showGameEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Image.asset('assets/images/congratulations.png', fit: BoxFit.cover),
            DefaultTextStyle(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              child: Text(
                  'Congratulations! You completed the game in $_timerValue seconds.'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Home()),
                // );
              },
              child: Text('OK'),
            ),
          ],
        );

        // return AlertDialog(
        //   title: Text('Game Over'),
        //   content: Container(
        //     height: 400,
        //     child: Column(
        //       children: [
        //         Image.asset(
        //           'assets/images/congratulations.png',
        //         ),
        //         Text(
        //             'Congratulations! You completed the game in $_timerValue seconds.'),
        //       ],
        //     ),
        //   ),
        //   actions: [
        //     TextButton(
        //       onPressed: () {
        //         // Navigator.of(context).pop();
        //         setState(() {
        //           startgame = false;
        //         });
        //         // Navigator.push(
        //         //   context,
        //         //   MaterialPageRoute(builder: (context) => const Home()),
        //         // );
        //       },
        //       child: Text('OK'),
        //     ),
        //   ],
        // );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
