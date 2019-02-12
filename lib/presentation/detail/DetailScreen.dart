import 'package:flutter/material.dart';
import 'package:flutter_project/model/trivia.dart';

class DetailScreen extends StatefulWidget {
  final Trivia trivia;

  DetailScreen(this.trivia);

  @override
  _DetailScreenState createState() => _DetailScreenState(trivia);
}

class _DetailScreenState extends State<DetailScreen> {
  final Trivia _trivia;

  _DetailScreenState(this._trivia);

  _showDialog(bool correct) async {
    bool close = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return AlertDialog(
            title: Text("La respuesta es:"),
            content: Text(correct ? "Correcta!" : "Incorrecta!"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(correct);
                  },
                  child: Text("Cerrar"))
            ],
          );
        });
    if (close) {
      Navigator.pop(context);
    }
  }

  _getBody(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<Widget> widgets = [];

    Widget question = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _trivia.question,
        style: textTheme.title,
      ),
    );

    Widget correctAnswer = Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
            shape: OutlineInputBorder(),
            onPressed: () {
              _showDialog(true);
            },
            child: Text(
              _trivia.correctAnswer,
            )));

    List<Widget> answers = _trivia.incorrectAnswers
        .map<Widget>((answer) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                shape: OutlineInputBorder(),
                onPressed: () {
                  _showDialog(false);
                },
                child: Text(answer))))
        .toList();

    answers.add(correctAnswer);
    answers.shuffle();

    widgets.add(question);
    widgets.addAll(answers);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgets,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pregunta"),
      ),
      body: _getBody(context),
    );
  }
}
