import 'package:hive/hive.dart';
part 'checklist.g.dart';

@HiveType(typeId: 6)
class Checklist {
  @HiveField(0)
  String? name;

  Checklist({
    required this.name,
  });
}
