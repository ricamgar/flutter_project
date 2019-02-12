import 'dart:convert';

import 'package:flutter_project/model/trivia.dart';
import 'package:http/http.dart' as network;

class TriviaRepository {

  const TriviaRepository();

  Future<List<Trivia>> getTrivia() async {
    network.Response response =
    await network.get('https://opentdb.com/api.php?amount=10');
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      List<Trivia> trivia = jsonBody['results'].map<Trivia>((element) {
        String question = element['question'];
        String correctAnswer = element['correct_answer'];
        List<String> incorrectAnswers = element['incorrect_answers'].map<String>((incorrect) {
          return incorrect.toString();
        }).toList();
        return Trivia(question, correctAnswer, incorrectAnswers);
      }).toList();
      return trivia;
    } else {
      throw Exception('Error fetching trivia');
    }
  }
}