import 'package:equatable/equatable.dart';
import '../../domain/entities/sleep_advice.dart';
import '../../domain/entities/sleep_goal.dart';

abstract class CoachState extends Equatable {
  const CoachState();
  @override
  List<Object?> get props => [];
}

class CoachInitial extends CoachState {
  const CoachInitial();
}

class CoachLoading extends CoachState {
  const CoachLoading();
}

class CoachLoaded extends CoachState {
  const CoachLoaded({
    required this.advices,
    required this.goal,
    required this.progress,
  });

  final List<SleepAdvice> advices;
  final SleepGoal goal;
  final GoalProgress progress;

  @override
  List<Object?> get props => [advices, goal, progress];
}

class CoachError extends CoachState {
  const CoachError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
