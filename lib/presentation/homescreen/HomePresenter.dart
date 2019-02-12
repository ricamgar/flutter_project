import 'package:flutter_project/data/TriviaRepository.dart';
import 'package:flutter_project/model/trivia.dart';
import 'package:flutter_project/presentation/homescreen/HomeView.dart';

class HomePresenter {
  final TriviaRepository _triviaRepository;
  final HomeView _view;

  HomePresenter(this._view, this._triviaRepository);

  fetchData() async {
    try {
      _view.showLoading();
      List<Trivia> trivia = await _triviaRepository.getTrivia();
      _view.showTrivia(trivia);
    } catch (e) {
      _view.showError();
    } finally {
      _view.hideLoading();
    }
  }

  elementClicked(Trivia trivia) {
    _view.openDetailScreen(trivia);
  }
}
