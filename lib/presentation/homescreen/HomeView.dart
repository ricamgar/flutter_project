import 'package:flutter_project/model/user.dart';

abstract class HomeView {
  openSettingsScreen(int position);

  showUsers(List<User> users);

  showLoading();

  hideLoading();

  showError();
}