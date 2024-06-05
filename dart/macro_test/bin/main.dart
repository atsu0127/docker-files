import 'package:macro_test/data.dart' as data;

void main(List<String> arguments) {
  var userJson = {'age': 5, 'name': 'Roger', 'username': 'roger1337'};

  var user = data.User.fromJson(userJson);
  print(user);
  print(user.toJson());
  print(data.Taro().hello());
  print(data.Jiro().hello());
}
