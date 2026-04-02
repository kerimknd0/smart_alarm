import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_coach_advice.dart';
import '../../domain/usecases/get_goal_progress.dart';
import '../../domain/usecases/get_sleep_goal.dart';
import '../../domain/usecases/save_sleep_goal.dart';
import 'coach_event.dart';
import 'coach_state.dart';

class CoachBloc extends Bloc<CoachEvent, CoachState> {
  CoachBloc({
    required this.getCoachAdvice,
    required this.getGoalProgress,
    required this.getSleepGoal,
    required this.saveSleepGoal,
  }) : super(const CoachInitial()) {
    on<LoadCoachDashboard>(_onLoad);
    on<RefreshCoach>(_onRefresh);
    on<SaveGoalEvent>(_onSaveGoal);
  }

  final GetCoachAdvice getCoachAdvice;
  final GetGoalProgress getGoalProgress;
  final GetSleepGoal getSleepGoal;
  final SaveSleepGoal saveSleepGoal;

  Future<void> _onLoad(
    LoadCoachDashboard event,
    Emitter<CoachState> emit,
  ) async {
    emit(const CoachLoading());
    await _fetchAndEmit(emit);
  }

  Future<void> _onRefresh(
    RefreshCoach event,
    Emitter<CoachState> emit,
  ) async {
    await _fetchAndEmit(emit);
  }

  Future<void> _onSaveGoal(
    SaveGoalEvent event,
    Emitter<CoachState> emit,
  ) async {
    try {
      await saveSleepGoal(event.goal);
      emit(const CoachLoading());
      await _fetchAndEmit(emit);
    } catch (e) {
      emit(CoachError(e.toString()));
    }
  }

  Future<void> _fetchAndEmit(Emitter<CoachState> emit) async {
    try {
      final results = await Future.wait([
        getCoachAdvice(),
        getSleepGoal(),
        getGoalProgress(),
      ]);
      emit(CoachLoaded(
        advices: results[0] as dynamic,
        goal: results[1] as dynamic,
        progress: results[2] as dynamic,
      ));
    } catch (e) {
      emit(CoachError(e.toString()));
    }
  }
}
