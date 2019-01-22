import 'package:flutter/material.dart';
import 'package:flutter_project/SettingsScreen.dart';
import 'package:flutter_project/homescreen/HomePresenter.dart';
import 'package:flutter_project/homescreen/HomeView.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeView {
  HomePresenter _homePresenter;
  List<String> _movies = [];

  _HomeScreenState() {
    _homePresenter = HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _homePresenter.init();
  }

  @override
  showMovies(List<String> movies) {
    setState(() {
      this._movies = movies;
    });
  }

  @override
  openSettingsScreen(int position) {
    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return SettingsScreen(position);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, position) {
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(_movies[position]),
            subtitle: Text("Subtitle $position"),
            onTap: () {
              _homePresenter.elementClicked(position);
            },
          );
        },
        itemCount: _movies.length,
        reverse: false,
      ),
    );
  }
}
