import 'package:json/json.dart';
import 'package:macro_test/macro.dart';

@JsonCodable()
class User {
  final int? age;
  final String name;
  final String username;
}

@Greetable()
class Taro {}

@Greetable()
class Jiro {}
