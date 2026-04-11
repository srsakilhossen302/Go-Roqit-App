import 'package:get_x/get.dart';
import 'package:go_roqit_app/service/api_url.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';

class ApiClient extends GetConnect implements GetxService {
  @override
  void onInit() {
    httpClient.baseUrl = ApiUrl.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    
    httpClient.addRequestModifier<void>((request) async {
      String token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      if (token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
        print("API Request: ${request.method} ${request.url}");
        print("Token added to header: Bearer $token");
      }
      return request;
    });
    
    super.onInit();
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      print("POST Request: $uri");
      print("POST Body: $body");
      Response response = await post(uri, body, headers: headers);
      print("POST Status: ${response.statusCode}");
      print("POST Response: ${response.body}");
      return response;
    } catch (e) {
      print("POST Error: $e");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getData(String uri, {Map<String, String>? headers, Map<String, dynamic>? query}) async {
    try {
      print("GET Request: $uri");
      print("GET Query: $query");
      Response response = await get(uri, headers: headers, query: query);
      print("GET Status: ${response.statusCode}");
      print("GET Response: ${response.body}");
      return response;
    } catch (e) {
      print("GET Error: $e");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  Future<Response> patchData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      print("PATCH Request: $uri");
      print("PATCH Body: $body");
      Response response = await patch(uri, body, headers: headers);
      print("PATCH Status: ${response.statusCode}");
      print("PATCH Response: ${response.body}");
      return response;
    } catch (e) {
      print("PATCH Error: $e");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
