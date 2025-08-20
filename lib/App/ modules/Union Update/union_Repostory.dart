// lib/App/modules/union/union_repository.dart
import 'package:dio/dio.dart';
import 'package:myamco/App/data/ModelClass/getUnionListModel.dart';
import 'package:myamco/App/data/provider/canstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnionRepository {
  final Dio _dio = Dio();

  Future<GetUnionListModel?> getUnionUpdates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final memberId = prefs.getString('member_id') ?? '';

      final url = '${Constants.baseUrl}notify_list';
      print("POST URL: $url");
      print("POST Body: { 'member_id': '$memberId' }");

      final response = await _dio.post(
        url,
        data: {'member_id': memberId}, // POST body
      );

      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return GetUnionListModel.fromJson(response.data);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception in getUnionUpdates: $e");
      return null;
    }
  }

}
