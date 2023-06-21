part of 'insert_cubit.dart';

@immutable
abstract class InsertState {}

class InsertInitial extends InsertState {}

class InsertLoading extends InsertState {}

class InsertLoaded extends InsertState {
  final int? statusCode;
  dynamic json;

  InsertLoaded({this.statusCode, this.json});
}
