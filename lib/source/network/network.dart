import 'dart:async';
import 'dart:io';
import 'package:batubara/source/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyNetwork {
  Future login(username, password, deviceid) async {
    try {
      var url = Uri.parse(MyApi.login(username, password, deviceid));
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan lemah', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n data mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future logout(username) async {
    try {
      var url = Uri.parse(MyApi.logout(username));
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan lemah', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n data mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future changePassword(username, password, newPassword) async {
    try {
      var url = Uri.parse(MyApi.changePassword(username, password, newPassword));
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan lemah', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n data mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future batubara() async {
    try {
      var url = Uri.parse(MyApi.batubara());
      var response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan lemah', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n data mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future insert(body) async {
    try {
      var url = Uri.parse(MyApi.insert());
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'Application/json',
            'Content-Type': 'Application/json',
          },
          body: body);
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan lemah', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n data mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }

  Future history(username) async {
    try {
      var url = Uri.parse(MyApi.history(username));
      var response = await http.post(url, headers: {'Authorization': 'Bearer $token'});
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n Jaringan lemah', duration: const Duration(seconds: 2));
    } on SocketException {
      EasyLoading.dismiss();
      EasyLoading.showError('Masalah Koneksi \n data mati', duration: const Duration(seconds: 2));
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message, duration: const Duration(seconds: 2));
    } on Error catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 2));
    }
  }
}
