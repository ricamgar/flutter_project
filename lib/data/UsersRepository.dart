import 'dart:convert';

import 'package:flutter_project/model/user.dart';
import 'package:http/http.dart' as network;

class UsersRepository {

  const UsersRepository();

  Future<List<User>> getUsers() async {
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
      return users;
    } else {
      throw Exception('Error fetching users');
    }
  }
}
