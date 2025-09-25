abstract class DamageCustomizationRepo {
  Future<bool> addNewDamage({required String? filePath, required Map<String, dynamic>? body});
  Future<bool> updateCurrentDamage({required String? filePath, required Map<String, dynamic>? body});
  Future<bool> deleteCurrentDamage({required int? id});
}
