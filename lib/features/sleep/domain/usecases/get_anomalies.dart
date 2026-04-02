import '../entities/sleep_analysis.dart';
import '../repositories/sleep_repository.dart';

class GetAnomalies {
  final SleepRepository repository;
  const GetAnomalies(this.repository);

  Future<List<SleepAnomaly>> call() => repository.getAnomalies();
}
