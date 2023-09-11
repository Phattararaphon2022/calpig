// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int caltotal = 10;
  List data = [];
  List ttt = [
    "aa",
    "bb",
    "cc",
  ];

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
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: heights * 0.05),
                child: const Text("Calories",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
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
                onPressed: () {
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
    ));
  }
}
