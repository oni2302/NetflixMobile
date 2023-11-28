import 'package:hive/hive.dart';
import 'package:netflix_mobile/models/user_model.dart';

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 0;

  @override
  Person read(BinaryReader reader) {
    return Person(
      username: reader.read(),
      id: reader.read(),
      currentPlan: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer.write(obj.username);
    writer.write(obj.id);
    writer.write(obj.currentPlan);
  }
}

