import 'dart:convert';

import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/presentation/homescreen/HomeView.dart';
import 'package:http/http.dart' as network;

class HomePresenter {
  HomeView _view;

  HomePresenter(this._view);

  fetchData() async {
    _view.showLoading();
    network.Response response =
        await network.get('https://randomuser.me/api/?results=10');
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      List<User> users = jsonBody['results'].map<User>((element) {
        String name = element['name']['first'];
        String lastName = element['name']['last'];
        String mail = element['email'];
        return User(name, lastName, mail);
      }).toList();
      _view.showUsers(users);
    } else {
      _view.showError();
    }
    _view.hideLoading();
  }

  elementClicked(int position) {
    _view.openSettingsScreen(position);
  }
}
