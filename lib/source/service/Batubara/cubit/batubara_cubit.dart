import 'dart:convert';

import 'package:batubara/source/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'batubara_state.dart';

class BatubaraCubit extends Cubit<BatubaraState> {
  final MyRepository? myRepository;
  BatubaraCubit({this.myRepository}) : super(BatubaraInitial());
  void getBatubara() async {
    emit(BatubaraLoading());
    myRepository!.batubara().then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('Batubara: $json');
      emit(BatubaraLoaded(statusCode: statusCode, json: json));
    });
  }
}
