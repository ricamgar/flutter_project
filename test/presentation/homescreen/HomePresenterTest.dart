import 'package:flutter_project/data/UsersRepository.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/presentation/homescreen/HomePresenter.dart';
import 'package:flutter_project/presentation/homescreen/HomeView.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHomeView extends Mock implements HomeView {}

class MockUsersRepo extends Mock implements UsersRepository {}

void main() {
  final mockView = MockHomeView();
  final mockRepo = MockUsersRepo();
  final usersList = [
    User('Test', 'TestName', 'TestMail'),
  ];

  test('Fetch data should return list of users', () async {
    when(mockRepo.getUsers()).thenAnswer((_) => Future.value(usersList));

    HomePresenter presenter = HomePresenter(mockView);

    await presenter.fetchData(usersRepository: mockRepo);
    verify(mockView.showLoading());
    verify(mockView.showUsers(usersList));
    verify(mockView.hideLoading());
  });

  test('Fetch data should show error when fetch fails', () async {
    when(mockRepo.getUsers()).thenAnswer((_) => Future.error(Exception()));

    HomePresenter presenter = HomePresenter(mockView);

    await presenter.fetchData(usersRepository: mockRepo);
    verify(mockView.showLoading());
    verify(mockView.showError());
    verify(mockView.hideLoading());
  });
}
