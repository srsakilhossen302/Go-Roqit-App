import 'package:get_x/get.dart';
import 'package:go_roqit_app/service/api_url.dart';

class ApiClient extends GetConnect implements GetxService {
  @override
  void onInit() {
    httpClient.baseUrl = ApiUrl.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      Response response = await post(uri, body, headers: headers ?? {'Content-Type': 'application/json'});
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
