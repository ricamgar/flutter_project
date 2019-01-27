import 'package:flutter_project/data/UsersRepository.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/presentation/homescreen/HomeView.dart';

class HomePresenter {
  HomeView _view;

  HomePresenter(this._view);

  fetchData({UsersRepository usersRepository = const UsersRepository()}) async {
    try {
      _view.showLoading();
      List<User> users = await usersRepository.getUsers();
      _view.showUsers(users);
    } catch (e) {
      _view.showError();
    } finally {
      _view.hideLoading();
    }
  }

  elementClicked(int position) {
    _view.openSettingsScreen(position);
  }
}
