import 'package:flutter/material.dart';
import 'package:flutter_project/homescreen/HomeView.dart';

class HomePresenter {
  HomeView _view;

  HomePresenter(this._view);

  elementClicked(int position) {
    _view.openSettingsScreen(position);
  }
}
