import 'package:batubara/source/network/network.dart';

class MyRepository {
  final MyNetwork? myNetwork;

  MyRepository({this.myNetwork});
  Future login(username, password, deviceid) async {
    var json = await myNetwork!.login(username, password, deviceid);
    return json;
  }

  Future logout(username) async {
    var json = await myNetwork!.logout(username);
    return json;
  }

  Future changePassword(username, password, newPassword) async {
    var json = await myNetwork!.changePassword(username, password, newPassword);
    return json;
  }

  Future batubara() async {
    var json = await myNetwork!.batubara();
    return json;
  }

  Future insert(body) async {
    var json = await myNetwork!.insert(body);
    return json;
  }
  Future history(username) async {
    var json = await myNetwork!.history(username);
    return json;
  }
}
