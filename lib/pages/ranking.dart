import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  late List<Player> ranking;
  // final List<Player> players = [
  //   Player(name: 'Player 1', score: 100),
  //   Player(name: 'Player 2', score: 90),
  //   Player(name: 'Player 3', score: 80),
  //   Player(name: 'Player 4', score: 70),
  //   Player(name: 'Player 5', score: 60),
  // ];

  // Function to get the current ranking
  Future<List<Player>> getCurrentRanking() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference itemsCollection = firestore.collection('ranking');

      // Query the items collection and order by the 'score' field in descending order
      QuerySnapshot querySnapshot = await itemsCollection.orderBy('time').get();

      // Extract the data from the documents
      List<Player> rankingList =
          querySnapshot.docs.map((DocumentSnapshot document) {
        return Player(
          itemId: document.id,
          name: document['name'],
          time: document['time'],
          // Add other fields if needed
        );
      }).toList();

      return rankingList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  getRankingslist() async {
    // Call the function to get the current ranking
    ranking = await getCurrentRanking();

    // Print or use the ranking data as needed
    print('Current Ranking:');
    ranking.forEach((item) {
      print('${item.itemId}: ${item.time}');
    });
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRankingslist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Game Ranking'),
        ),
        body: FutureBuilder(
            future: getRankingslist(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: ranking.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(ranking[index].name),
                      subtitle: Text('Time : ${ranking[index].time} seconds'),
                      leading: index == 0
                          ? Image.asset('assets/images/gold.png')
                          : index == 1
                              ? Image.asset('assets/images/silver.png')
                              : index == 2
                                  ? Image.asset('assets/images/copper.png')
                                  : CircleAvatar(
                                      child: Text((index + 1)
                                          .toString()), // Display ranking number
                                    ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class Player {
  final String itemId;
  final String name;
  final int time;

  Player({required this.itemId, required this.name, required this.time});
}
