import 'package:hive/hive.dart';

part 'star_record.g.dart';

@HiveType(typeId: 0)
class StarRecord extends HiveObject{
  @HiveField(0)
  String ageGroup;

  @HiveField(1)
  String gameId;

  @HiveField(2)
  int stars;

  @HiveField(3)
  DateTime lastPlayed;

  StarRecord({
    required this.ageGroup,
    required this.gameId,
    required this.stars,
    required this.lastPlayed,
  });
}