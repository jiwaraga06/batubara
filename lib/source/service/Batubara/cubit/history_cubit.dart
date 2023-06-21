import 'dart:convert';

import 'package:batubara/source/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final MyRepository? myRepository;
  HistoryCubit({required this.myRepository}) : super(HistoryInitial());

  void getHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    print(username);
    emit(HistoryLoading());
    myRepository!.history(username).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('History: $json');
      emit(HistoryLoaded(statusCode: statusCode, json: json));
    });
  }
}
