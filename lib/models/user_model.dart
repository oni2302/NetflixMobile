import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Person {
  Person({required this.username, required this.id, required this.currentPlan ,this.isLoggedIn=false});

  @HiveField(0)
  String username;

  @HiveField(1)
  int id;

  @HiveField(2)
  int currentPlan;

  bool isLoggedIn=false;
  @override
  String toString() {
    return '$username: $currentPlan';
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    Person r;
    json['isLoggedIn'] = (json['isLoggedIn']==1);
    try {
      r = Person(
        username: json['username'] as String,
        id: json['id'] as int,
        currentPlan: json['currentService'] as int,
        isLoggedIn: json['isLoggedIn'] as bool
      );
    }catch (e) {
      r = Person(username: "", id: 0, currentPlan: 0);
    }
    return r;
  }
}
