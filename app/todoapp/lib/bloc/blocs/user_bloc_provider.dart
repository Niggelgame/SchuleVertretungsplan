import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todoapp/models/classes/user.dart';

class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<User>();

  Observable<User> get getUser => _userGetter.stream;

  registerUser(String username, String firstname, String lastname, String password, String email) async {
    User user = await _repository.registerUser(username, firstname, lastname, password, email);
    _userGetter.sink.add(user);
  }

  Future<bool> signinUser(String username, String password, String apiKey) async {
    return await _repository.signinUser(username, password, apiKey);
    //_userGetter.sink.add(user);
  }

  getData(String apiKey) async {
    String data = await _repository.getData(apiKey);
    return data;
  }

  dispose() {
    _userGetter.close();
  }

}

final bloc = UserBloc();