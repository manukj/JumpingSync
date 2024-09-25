import 'package:Vyayama/resource/firebase/db_service.dart';
import 'package:Vyayama/resource/firebase/model/reps_record.dart';
import 'package:Vyayama/resource/logger/logger.dart';
import 'package:get/get.dart';

class RecordViewModel extends GetxController {
  final DbService _dbService = Get.find<DbService>();

  Rx<List<RepsRecord>> records = Rx<List<RepsRecord>>([]);
  Rx<bool> isLoading = Rx<bool>(false);

  Future<void> fetchRecords() async {
    isLoading.value = true;
    records.value = await _dbService.fetchReps();
    isLoading.value = false;
  }

  Future<void> saveRecord(int newCount) async {
    try {
      isLoading.value = true;
      await _dbService.saveRecord(newCount);
      fetchRecords();
      isLoading.value = false;
    } catch (e) {
      appLogger.error(e.toString());
      rethrow;
    }
  }

  int? getTodayRecord() {
    final today = DateTime.now();
    final record = records.value.firstWhere(
      (element) => element.date.day == today.day,
      orElse: () => RepsRecord(date: today, count: 0),
    );
    return record.count;
  }
}
