import 'package:equatable/equatable.dart';
import '../../domain/entities/sleep_goal.dart';

abstract class CoachEvent extends Equatable {
  const CoachEvent();
  @override
  List<Object?> get props => [];
}

class LoadCoachDashboard extends CoachEvent {
  const LoadCoachDashboard();
}

class SaveGoalEvent extends CoachEvent {
  const SaveGoalEvent(this.goal);
  final SleepGoal goal;
  @override
  List<Object?> get props => [goal];
}

class RefreshCoach extends CoachEvent {
  const RefreshCoach();
}
