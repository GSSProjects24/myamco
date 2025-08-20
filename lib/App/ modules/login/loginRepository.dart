// lib/App/data/repository/login_repository.dart
import 'package:dio/dio.dart';
import 'package:myamco/App/data/provider/canstant.dart';


class LoginRepository {
  final Dio dio = Dio();

  Future<Response> login(String email, String password) async {
    var data = {
      "email": email,
      "password": password,
    };

    var response = await dio.request(
      '${Constants.baseUrl}member_login', // ✅ Change to your login endpoint
      options: Options(
        method: 'POST',
      ),

      data: data,

    );

    return response;
  }
}
