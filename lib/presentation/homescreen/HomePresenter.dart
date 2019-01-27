import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/presentation/homescreen/HomeView.dart';

class HomePresenter {
  HomeView _view;

  HomePresenter(this._view);

  fetchData() async {
    _view.showLoading();
    QuerySnapshot snapshot =
        await Firestore.instance.collection('users').getDocuments();
    if (snapshot.documents.length > 0) {
      List<User> users = snapshot.documents.map<User>((document) {
        String name = document['name'];
        String lastName = document['last_name'];
        String mail = document['email'];
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
