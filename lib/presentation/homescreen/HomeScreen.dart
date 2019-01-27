import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/homescreen/HomePresenter.dart';
import 'package:flutter_project/presentation/homescreen/HomeView.dart';
import 'package:flutter_project/presentation/settings/SettingsScreen.dart';
import 'package:flutter_project/model/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeView {
  HomePresenter _homePresenter;
  List<User> _users = [];
  bool _isLoading = true;
  bool _isError = false;

  _HomeScreenState() {
    _homePresenter = HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _homePresenter.fetchData();
  }

  @override
  openSettingsScreen(int position) {
    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return SettingsScreen(position);
    }));
  }

  @override
  showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  showError() {
    setState(() {
      _isError = true;
    });
  }

  @override
  showUsers(List<User> users) {
    setState(() {
      this._users = users;
    });
  }

  buildBody() {
    if (_isLoading) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90.0),
        child: CircularProgressIndicator(),
      ));
    }
    else if (_isError) {
      return Center(child: Text("Ha habido un error"));
    } else {
      return RefreshIndicator(
        onRefresh: () {
          _homePresenter.fetchData();
        },
        child: ListView.builder(
          itemBuilder: (context, position) {
            return ListTile(
              leading: Icon(Icons.account_circle),
              title:
                  Text(_users[position].name + " " + _users[position].lastName),
              subtitle: Text(_users[position].mail),
              onTap: () {
                _homePresenter.elementClicked(position);
              },
            );
          },
          itemCount: _users.length,
          reverse: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }
}
