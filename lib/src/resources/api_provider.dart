import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/pref_manager.dart';

enum Method {POST, GET, PATCH, DELETE}

class ApiProvider {
  static String _baseUrl = "http://192.168.8.100/coders/keak/";
  final String baseUrl = "$_baseUrl";
  final String apiUrl = "${_baseUrl}api/v1/";
  final int keepOnCache = 3;
  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();

  ApiProvider() {
    initDioOptions();
  }

  initDioOptions() async {
    dio.options.baseUrl = apiUrl;
    dio.options.connectTimeout = 20000; //10s
    dio.options.receiveTimeout = 20000; //10s
    dio.options.contentType = "application/json";
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: apiUrl)).interceptor);
    dio.options.headers = {
      "Content-Type": "application/json",
    };
  }

  void close() {
    if(!cancelToken.isCancelled){
      cancelToken.cancel("Close");
    }
    dio.close();
  }

  Future<Map<String , dynamic>> auth(String phone) async {
    return _doRequest("auth/login.php", Method.POST, request: {
      "phone": phone,
    }, forceRefresh: true);
  }

  Future<Map<String , dynamic>> registerData(String name, Map<String, dynamic> request) async {
    String token = await PrefManager().get("token", "");
    return _doRequest("manage/$name", Method.POST, request: {
      "token": token,
    }..addAll(request), forceRefresh: true);
  }

  Future<Map<String , dynamic>> lookups(String name, Map<String, dynamic> request) async {
    String token = await PrefManager().get("token", "");
    return _doRequest("lookups/$name", Method.GET, request: {
      "token": token,
    }..addAll(request), forceRefresh: true);
  }

  Future<Map<String, dynamic>> _doRequest(String path, Method method,
  {Map<String, dynamic> request, bool forceRefresh = false}) async {

//    forceRefresh = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return {
        "success": false,
        "error_code": -1,
        "message": lang.text("No internet connectivity")
      };
    }
    print("path: $path");
    print("request: $request");
    try {
      Response response;
      if (method == Method.POST) {
        response = await dio.post(
          path,
          data: json.encode(request),
          cancelToken: cancelToken,
          onSendProgress: (int sent, int total) {},
          onReceiveProgress: (int receive, int total){},
          options: buildCacheOptions(Duration(days: keepOnCache), maxStale: Duration(days: keepOnCache), forceRefresh: forceRefresh),
        );
      } else if (method == Method.PATCH) {
        response = await dio.patch(path,
          data: request,
          cancelToken: cancelToken,
          options: buildCacheOptions(Duration(days: keepOnCache), maxStale: Duration(days: keepOnCache), forceRefresh: forceRefresh),
        );
      } else if (method == Method.DELETE) {
        response = await dio.delete(path, data: request, cancelToken: cancelToken);
      } else if (method == Method.GET) {
        response = await dio.get(path,
          queryParameters: request,
          options: buildCacheOptions(Duration(days: keepOnCache), maxStale: Duration(days: keepOnCache), forceRefresh: forceRefresh),
        );
      }
      if (response != null) {
        print("response.statusCode: ${response.statusCode}");
        print("response.body: ${response.data}");
        if(response.statusCode == 200){
          var responseData = response.data;
          Map data;
          if(responseData is String){
            data = json.decode(responseData);
          } else {
            data = responseData;
          }
          return data;
        } else {
          return {
            "success": false,
            "error_code": response.statusCode,
            "message": lang.text("Server error")
          };
        }
      }
    } on Exception catch (e) {
      print("Exception: $e");
    }
    return {
      "success": false,
      "code": 0,
      "error_code": -1001,
      "message": lang.text("No internet connectivity")
    };
  }

  String fullUrl(String url, Map<String, dynamic> request){
    url += "?";
    request.keys.toList().forEach((String key){
      if(request[key] is List){
        List value = request[key];
        value.forEach((element) {
          url += "$key[]=${Uri.encodeComponent(element)}&";
        });
      } else {
        String value = Uri.encodeComponent("${request[key]}");
        url += "$key=$value&";
      }
    });
    return url;
  }
}