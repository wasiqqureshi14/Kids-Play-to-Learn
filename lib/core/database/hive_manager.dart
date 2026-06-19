import 'package:hive_flutter/hive_flutter.dart';
import 'models/star_record.dart';

class HiveManager {

  static const String starsBox = 'stars_box';

  static Future<void> init() async{

    await Hive.initFlutter();

    Hive.registerAdapter(StarRecordAdapter());

    await Hive.openBox<StarRecord>(starsBox);
  }

  static Box<StarRecord> get stars => Hive.box<StarRecord>(starsBox);
}