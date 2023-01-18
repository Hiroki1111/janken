import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({super.key});

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  // 変数はここに書く
  String myHand = "✊";
  String completerHand = "✊";
  String result = "引き分け";
  String judgePrint = "";
  int judgeCount = 0;
  int winCount = 0;
  int loseCount = 0;
  int drawCount = 0;

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    print(myHand);
    generateCompleterHand();
    judge();
    judgeCounter();
    winCounter();
    loseCounter();
    drawCounter();
    judgePrinter();
    setState(() {});
  }

  void generateCompleterHand() {
    final randomNumber = Random().nextInt(3);
    completerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return "✊";
      case 1:
        return "✌️";
      case 2:
        return "🖐";
      default:
        return "✊";
    }
  }

  void judge() {
    // 引き分けの場合
    if (myHand == completerHand) {
      result = "引き分け";
    } else if (myHand == "✊" && completerHand == "✌️" ||
        myHand == "✌️" && completerHand == "🖐" ||
        myHand == "🖐" && completerHand == "✊") {
      result = "勝ち";
    } else {
      result = "負け";
    }
  }

  void judgeCounter() {
    judgePrint = "";
    judgeCount++;
    if (judgeCount == 5) {
      judgePrinter();
      myHand = "✊";
      completerHand = "✊";
      result = "引き分け";
      judgeCount = 0;
      winCount = 0;
      loseCount = 0;
      drawCount = 0;
    }
  }

  void winCounter() {
    if (result == "勝ち") {
      winCount++;
    }
  }

  void loseCounter() {
    if (result == "負け") {
      loseCount++;
    }
  }

  void drawCounter() {
    if (result == "引き分け") {
      drawCount++;
    }
  }

  void judgePrinter() {
    if (judgeCount == 4) {
      judgePrint = "5戦$winCount勝$loseCount敗$drawCount分";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("じゃんけん"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              judgePrint,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              result,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              completerHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              myHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand("✊");
                  },
                  child: const Text("✊"),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand("✌️");
                  },
                  child: const Text("✌️"),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand("🖐");
                  },
                  child: const Text("🖐"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
