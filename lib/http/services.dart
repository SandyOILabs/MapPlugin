import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/poi_model.dart';

class InternetService {
  Future<GetPoi?> getPOI() async {
    Map data = {
      "appname": "bom",
      "token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNTk1Zjc1NmY1NGVkYWYyMzA4MjYzMTlhIiwiaWF0IjoxNDk5ODc2OTM4LCJleHAiOjE1NTE3MTY5Mzh9.9vFu_xjGMNb_w_1i-qIuxI9pUkdAMFkRqvmHmJAByHk",
      "isPartner": "false"
    };
    http.Response response;
    try {
      response = await http.post(
          Uri.parse("https://airport.wisefly.in/poisroute/getpois"),
          // headers: {"Content-Type": "application/json"},
          body: data);

      if (response.statusCode == 200) {
        GetPoi poiData = GetPoi.fromJson(jsonDecode(response.body));
        return poiData;
      } else {
        return null;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
