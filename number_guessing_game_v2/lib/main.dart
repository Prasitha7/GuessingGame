import 'package:flutter/material.dart';

void main() {
  runApp(NumberGuessingApp());
}

class NumberGuessingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guessing Game',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int secretNumber;
  int attemptsLeft = 3;
  int currentAttempt = 0;
  TextEditingController _guessController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateSecretNumber();
  }

  void generateSecretNumber() {
    secretNumber = (DateTime.now().millisecondsSinceEpoch %
        10); // Generate a random number from 1 to 10
  }

  void checkGuess(int guess) {
    if (guess == secretNumber) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CorrectGuessPage(secretNumber)),
      );
    } else {
      setState(() {
        attemptsLeft--;
        if (attemptsLeft == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameOverPage(secretNumber)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WrongGuessPage()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Guessing Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/guess.png'),
              width: 200,
              height: 200,
            ),
            Text(
              'I have a secret number in my mind (1 - 10).\nYou have $attemptsLeft chances to guess it.',
              textAlign: TextAlign.center,
            ),
            Text(
              ' $currentAttempt of 3 chances are taken.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _guessController,
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_guessController.text.isNotEmpty) {
                  int guess = int.parse(_guessController.text);
                  checkGuess(guess);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class CorrectGuessPage extends StatelessWidget {
  final int correctNumber;

  CorrectGuessPage(this.correctNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Correct Guess!'),
      ),
      backgroundColor: const Color.fromARGB(255, 113, 202, 116),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Yes! Ypu guessed it right. My secret Number is.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              '$correctNumber',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
              child: Text('Start The Game Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class WrongGuessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrong Guess'),
      ),
      backgroundColor: const Color.fromARGB(255, 218, 118, 111),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sorry! Wrong guess. Please try again.',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the home screen
              },
              child: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameOverPage extends StatelessWidget {
  final int rightNumber;

  GameOverPage(this.rightNumber);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Over'),
      ),
      backgroundColor: const Color.fromARGB(255, 123, 184, 235),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sorry Game Over. my secret number is',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              '$rightNumber',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
