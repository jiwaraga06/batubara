import 'dart:convert';

import 'package:batubara/source/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'insert_state.dart';

class InsertCubit extends Cubit<InsertState> {
  final MyRepository? myRepository;
  InsertCubit({required this.myRepository}) : super(InsertInitial());

  void insert(idMesin, keterangan, namaMesin, total, aktual, hz, netto, details) async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    var username = pref.getString('username');
    DateTime date = DateTime.now();
    var tanggal = date.toString().split(' ')[0];
    var body = {
      "tanggal": "$tanggal",
      "id_mesin": "$idMesin",
      "nama_mesin": "$namaMesin",
      "keterangan": "$keterangan",
      "created_by": "$username",
      "total": "$total",
      "netto": "$netto",
      "aktual": "$aktual",
      "speed_converter": "$hz",
      "detail": details
    };
    print("BODY: $body");
    emit(InsertLoading());
    myRepository!.insert(jsonEncode(body)).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('CODE: $statusCode');
      print('JSON: $json');
      emit(InsertLoaded(statusCode: statusCode, json: json));
    });
  }
}
