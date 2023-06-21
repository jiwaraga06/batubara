part of 'batubara_cubit.dart';

@immutable
abstract class BatubaraState {}

class BatubaraInitial extends BatubaraState {}

class BatubaraLoading extends BatubaraState {}

class BatubaraLoaded extends BatubaraState {
  final int? statusCode;
  dynamic json;

  BatubaraLoaded({this.statusCode, this.json});
}
