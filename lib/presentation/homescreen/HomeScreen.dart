import 'package:flutter/material.dart';
import 'package:flutter_project/data/TriviaRepository.dart';
import 'package:flutter_project/model/trivia.dart';
import 'package:flutter_project/presentation/detail/DetailScreen.dart';
import 'package:flutter_project/presentation/homescreen/HomePresenter.dart';
import 'package:flutter_project/presentation/homescreen/HomeView.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeView {
  HomePresenter _homePresenter;
  List<Trivia> _trivia = [];
  bool _isLoading = true;
  bool _isError = false;

  _HomeScreenState() {
    _homePresenter = HomePresenter(this, TriviaRepository());
  }

  @override
  void initState() {
    super.initState();
    _homePresenter.fetchData();
  }

  @override
  openDetailScreen(Trivia trivia) {
    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return DetailScreen(trivia);
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
  showTrivia(List<Trivia> trivia) {
    setState(() {
      this._trivia = trivia;
    });
  }

  buildBody() {
    if (_isLoading) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90.0),
        child: CircularProgressIndicator(),
      ));
    } else if (_isError) {
      return Center(child: Text("Ha habido un error"));
    } else {
      return RefreshIndicator(
        onRefresh: () {
          _homePresenter.fetchData();
        },
        child: ListView.builder(
          itemBuilder: (context, position) {
            Trivia trivia = _trivia[position];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.help),
                title: Text(trivia.question),
                onTap: () {
                  _homePresenter.elementClicked(trivia);
                },
              ),
            );
          },
          itemCount: _trivia.length,
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
