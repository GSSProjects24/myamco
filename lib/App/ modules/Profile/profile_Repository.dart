import 'package:dio/dio.dart';
import 'package:myamco/App/data/ModelClass/profileModel.dart';
import 'package:myamco/App/data/provider/canstant.dart';


class ProfileRepository {
  final Dio dio = Dio();

  Future<ProfileModel> fetchProfile(String memberId) async {
    var data = {
      "member_id": memberId,

    };
    try {
      var response = await dio.request(
        '${Constants.baseUrl}member_profile', // ✅ Change to your login endpoint
        options: Options(
          method: 'POST',
        ),

        data: data,

      );
      print("$Data}");
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load profile: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching profile: $e");
    }
  }
}
