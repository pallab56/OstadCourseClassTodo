import 'dart:convert';

import 'package:classtodoapp/models/api_response.dart';
import 'package:http/http.dart';

class ApiCaller {
  static Future<ApiResponse> getRequest({required String url}) async {
    Response response = await get(Uri.parse(url), headers: {});

    print("URL === $url");
    print("URL Body====${response.body}");

    if (response.statusCode == 200) {
      return ApiResponse(
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isScuccess: true,
      );
    } else {
      return ApiResponse(
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isScuccess: jsonDecode(response.body),
      );
    }
  }

  static Future<ApiResponse> postRequest({required String url , required Map<String,dynamic>?body}) async {
    Response response = await post(Uri.parse(url), 
    headers: {
      "Content-Type":"application/json",
      "Accept":"application/json"
    },
    body: body != null?jsonEncode(body):null
    );

    print("URL === $url");
    print("URL Body====${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isScuccess: true,
      );
    } else {
      return ApiResponse(
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
        isScuccess: jsonDecode(response.body),
      );
    }
  }
}
