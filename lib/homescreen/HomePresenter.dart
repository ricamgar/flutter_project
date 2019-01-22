import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/homescreen/HomeView.dart';

class HomePresenter {
  HomeView _view;

  HomePresenter(this._view);

  init() async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection('movies').getDocuments();
    List<String> movies = snapshot.documents.map((document) {
      print("Movie: ${document['title']}");
      return document['title'].toString();
    }).toList();
    _view.showMovies(movies);
  }

  elementClicked(int position) {
    _view.openSettingsScreen(position);
  }
}
