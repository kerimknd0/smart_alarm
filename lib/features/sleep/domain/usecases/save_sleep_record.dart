import '../entities/sleep_record.dart';
import '../repositories/sleep_repository.dart';

class SaveSleepRecord {
  final SleepRepository repository;
  const SaveSleepRecord(this.repository);

  Future<void> call(SleepRecord record) => repository.saveSleepRecord(record);
}
