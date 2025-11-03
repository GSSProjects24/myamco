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

      // ✅ Get both user_id and member_id
      final userId = prefs.getString('user_id') ?? '';
      final memberId = prefs.getString('member_id') ?? '';

      final url = '${Constants.baseUrl}notify_list';
      print("POST URL: $url");
      print("POST Body: { 'user_id': '$userId', 'member_id': '$memberId' }");

      final response = await _dio.post(
        url,
        data: {
          'user_id': userId,      // ✅ Add user_id
          'member_id': memberId,  // ✅ Keep member_id
        },
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
