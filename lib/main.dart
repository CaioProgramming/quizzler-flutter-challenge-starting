import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {

      print('is quiz finished? ${quizBrain.isFinished()}');
      if (quizBrain.isFinished()) {
        print('quiz is finished need to restart');
        Alert(
            context: this.context,
            type: AlertType.success,
            style: AlertStyle(
              animationType: AnimationType.grow,
              animationDuration: Duration(milliseconds: 500),
            ),
            title: 'Parabéns!',
            desc: 'Você respondeu todas as questões!',buttons: [
          DialogButton(color: Colors.transparent,child: Text('Tentar novamente',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),), onPressed: () {
            quizBrain.resetQuestion();
            Navigator.pop(context);
            clearScore();
          },)
        ],closeFunction: () {
          clearScore();
        }).show();
      }else{
        scoreKeeper.add(addIcon(userPickedAnswer == correctAnswer));
        quizBrain.nextQuestion();
      }
    });
  }
  Widget addIcon(bool iscorrect) {
    if(iscorrect){
      return Expanded(
        flex: 2,
        child: Icon(Icons.check,
          color: Colors.green,
        ),
      );
    }
    return Expanded(
      child: Icon(Icons.close,
        color: Colors.red,
      ),
    );
  }
  void clearScore(){
    setState(() {
      scoreKeeper.clear();
    });
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
