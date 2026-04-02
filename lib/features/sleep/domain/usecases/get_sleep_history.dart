import '../entities/sleep_record.dart';
import '../repositories/sleep_repository.dart';

class GetSleepHistory {
  final SleepRepository repository;
  const GetSleepHistory(this.repository);

  Future<List<SleepRecord>> call({int limit = 30}) =>
      repository.getSleepHistory(limit: limit);
}
