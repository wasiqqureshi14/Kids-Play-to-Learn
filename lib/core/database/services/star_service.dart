import 'package:hive/hive.dart';
import '../hive_manager.dart';
import '../models/star_record.dart';

class StarService {

  Box<StarRecord> get _box => HiveManager.stars;

  Future<void> saveStars({
    required String ageGroup,
    required String gameId,
    required int stars,
  }) async {
    final Key = _makeKey(ageGroup, gameId);

    final existing = _box.get(Key);

    if(existing != null){

      if(stars > existing.stars){
        existing.stars = stars;
        existing.lastPlayed = DateTime.now();
        await existing.save();
      }
    } else{
      await _box.put(Key , StarRecord(ageGroup: ageGroup, 
      gameId: gameId,
       stars: stars,
       lastPlayed: DateTime.now(),));
    }
  }
   int getStars({required String ageGroup, required String gameId}) {
    final key = _makeKey(ageGroup, gameId);
    return _box.get(key)?.stars ?? 0;   // 0 if never played
  }

  /// Get all stars for an age group (total)
  int getTotalStars(String ageGroup) {
    return _box.values
        .where((record) => record.ageGroup == ageGroup)
        .fold(0, (sum, record) => sum + record.stars);
  }

  /// Get all records for an age group
  List<StarRecord> getRecordsByAge(String ageGroup) {
    return _box.values
        .where((record) => record.ageGroup == ageGroup)
        .toList();
  }

  /// Check if a game was ever played
  bool isGamePlayed({required String ageGroup, required String gameId}) {
    final key = _makeKey(ageGroup, gameId);
    return _box.containsKey(key);
  }

  // ─── DELETE ───────────────────────────────────────

  /// Reset stars for one game only
  Future<void> resetGame({
    required String ageGroup,
    required String gameId,
  }) async {
    final key = _makeKey(ageGroup, gameId);
    await _box.delete(key);
  }

  /// Reset ALL stars for an age group
  Future<void> resetAgeGroup(String ageGroup) async {
    final keysToDelete = _box.keys.where((key) {
      return (key as String).startsWith(ageGroup);
    }).toList();

    await _box.deleteAll(keysToDelete);
  }

  /// Wipe everything (factory reset)
  Future<void> resetAll() async {
    await _box.clear();
  }

  // ─── HELPER ───────────────────────────────────────

  /// Unique key = "age_2_3__shape_match"
  String _makeKey(String ageGroup, String gameId) {
    return '${ageGroup}__$gameId';
  }
}
