import 'dart:convert';

import 'package:management_store/screens/dataclass.dart';
import 'package:http/http.dart' as http;

class Service {
  // mengambil keseluruhan data menggunakan async, await, future

  Future<List<storeData>> getAllData() async {
    final response = await http.get(
      Uri.parse('http://10.10.4.193:8000/api/management-store/'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => storeData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future postData(
    // int id,
    String name,
    String description,
    String stock,
  ) async {
    final response = await http.post(
        Uri.parse('http://10.10.4.193:8000/api/management-store/'),
        body: {
          "name": name,
          "description": description,
          "stock": stock,
        });
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to push data');
    }
  }

  Future<bool> deleteData(id) async {
    final response = await http.delete(
        Uri.parse('http://10.10.4.193:8000/api/management-store/$id/'));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to Delete');
    }
  }
}
