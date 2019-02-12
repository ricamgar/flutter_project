import 'package:flutter_project/model/trivia.dart';

abstract class HomeView {
  openDetailScreen(Trivia trivia);

  showTrivia(List<Trivia> trivia);

  showLoading();

  hideLoading();

  showError();
}
