part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final int? statusCode;
  dynamic json;

  HistoryLoaded({this.statusCode, this.json});
}
