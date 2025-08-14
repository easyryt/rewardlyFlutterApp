// import 'dart:convert';
//
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:path_provider/path_provider.dart';
//
// class ApiClient {
//   final Dio _dio = Dio();
//   final String _baseUrl = 'https://advertiserappnew.onrender.com/';
//   // final String _baseUrl = 'https://advertiserapp.onrender.com/';
//
//   String? token;
//   Map<String, String>? mainHeaders;
//   late CookieJar cookieJar;
//
//   ApiClient() {
//     _dio.options.baseUrl = _baseUrl;
//
//     // cookieJar = CookieJar();
//     getApplicationDocumentsDirectory().then((dir) {
//       cookieJar = PersistCookieJar(
//         storage: FileStorage("${dir.path}/.cookies"),
//       );
//       _dio.interceptors.add(CookieManager(cookieJar));
//     });
//   }
//
//   updateHeader(String? token) {
//     if (token != null) {
//       Map<String, String> header = {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-user-token': token
//       };
//       mainHeaders = header;
//     } else {
//       mainHeaders = {
//         'Content-Type': 'application/json; charset=UTF-8',
//       };
//     }
//   }
//
//   Future<Response> getData(String path) async {
//     try {
//       Response response = await _dio
//           .get(
//             _baseUrl + path,
//             // options: Options(headers: headers ?? mainHeaders),
//           )
//           .timeout(const Duration(seconds: 90));
//       return response;
//     } catch (e) {
//       print(e.toString());
//       return Response(
//         statusCode: 1,
//         requestOptions: RequestOptions(
//           //  headers: headers,
//           baseUrl: _baseUrl + path,
//         ),
//       );
//     }
//   }
//
//   Future<Response> postData(
//       String path, body, Map<String, dynamic>? headers) async {
//     try {
//       Response response = await _dio
//           .post(
//             _baseUrl + path,
//             data: body,
//             //  options: Options(headers: headers ?? mainHeaders),
//           )
//           .timeout(const Duration(seconds: 90));
//       return response;
//     } catch (e) {
//       print(e.toString());
//       if (e is DioException && e.response != null) {
//         return Response(
//           statusCode: e.response!.statusCode ?? 1,
//           data: e.response!,
//           requestOptions: e.response!.requestOptions,
//         );
//       } else {
//         return Response(
//           statusCode: 1,
//           requestOptions: RequestOptions(
//             //  headers: headers,
//             baseUrl: _baseUrl + path,
//           ),
//         );
//       }
//     }
//   }
//
//   Future<Response> putData(String path, Map<String, dynamic> body,
//       Map<String, dynamic>? headers) async {
//     try {
//       Response response = await _dio
//           .put(
//             _baseUrl + path,
//             data: jsonEncode(body),
//             //  options: Options(headers: headers ?? mainHeaders),
//           )
//           .timeout(const Duration(seconds: 90));
//       return response;
//     } catch (e) {
//       print(e.toString());
//       return Response(
//         statusCode: 1,
//         requestOptions: RequestOptions(
//           // headers: headers,
//           baseUrl: _baseUrl + path,
//         ),
//       );
//     }
//   }
//
//   Future<Response> patchData(String path, Map<String, dynamic> body,
//       Map<String, dynamic>? headers) async {
//     try {
//       Response response = await _dio
//           .patch(
//             _baseUrl + path,
//             data: jsonEncode(body),
//             options: Options(headers: headers ?? mainHeaders),
//           )
//           .timeout(const Duration(seconds: 90));
//       return response;
//     } catch (e) {
//       //  print(e.toString());
//       return Response(
//         statusCode: 1,
//         requestOptions: RequestOptions(
//           headers: headers,
//           baseUrl: _baseUrl + path,
//         ),
//       );
//     }
//   }
//
//   Future<Response> postFormData(
//       String path, body, Map<String, dynamic>? headers) async {
//     try {
//       Response response = await _dio
//           .post(
//             _baseUrl + path,
//             data: body,
//             options: Options(headers: headers ?? mainHeaders),
//           )
//           .timeout(const Duration(seconds: 90));
//       return response;
//     } catch (e) {
//       //  print(e.toString());
//       if (e is DioException && e.response != null) {
//         return Response(
//           statusCode: e.response!.statusCode ?? 1,
//           data: e.response!,
//           requestOptions: e.response!.requestOptions,
//         );
//       } else {
//         return Response(
//           statusCode: 1,
//           requestOptions: RequestOptions(
//             headers: headers,
//             baseUrl: _baseUrl + path,
//           ),
//         );
//       }
//     }
//   }
//
//   Future<Response> deleteData(
//       String path, Map<String, dynamic>? headers) async {
//     try {
//       Response response = await _dio
//           .delete(
//             _baseUrl + path,
//             options: Options(headers: headers ?? mainHeaders),
//           )
//           .timeout(const Duration(seconds: 90));
//       return response;
//     } catch (e) {
//       //  print(e.toString());
//       return Response(
//         statusCode: 1,
//         requestOptions: RequestOptions(
//           headers: headers,
//           baseUrl: _baseUrl + path,
//         ),
//       );
//     }
//   }
//
//   Future<Response> getDataWithParams(String path, Map<String, dynamic>? headers,
//       Map<String, dynamic>? params) async {
//     try {
//       Response response = await _dio
//           .get(
//             _baseUrl + path,
//             options: Options(headers: headers ?? mainHeaders),
//             queryParameters: params,
//           )
//           .timeout(const Duration(seconds: 90));
//       return response;
//     } catch (e) {
//       // print(e.toString());
//       return Response(
//         statusCode: 1,
//         requestOptions: RequestOptions(
//           headers: headers,
//           baseUrl: _baseUrl + path,
//         ),
//       );
//     }
//   }
// }

import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class ApiClient {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://advertiserappnew.onrender.com/';
  String? token;
  Map<String, String>? mainHeaders;
  late CookieJar cookieJar;

  ApiClient() {
    _dio.options.baseUrl = _baseUrl;
    getApplicationDocumentsDirectory().then((dir) {
      cookieJar = PersistCookieJar(
        storage: FileStorage("${dir.path}/.cookies"),
      );
      _dio.interceptors.add(CookieManager(cookieJar));
    });
  }

  updateHeader(String? token) {
    if (token != null) {
      mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-user-token': token
      };
    } else {
      mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    }
  }

  // Common error handler
  Response _handleError(
      DioException e, String url, Map<String, dynamic>? headers) {
    if (e.response != null) {
      return Response(
        statusCode: e.response?.statusCode,
        data: e.response?.data ??
            {"message": e.response?.statusMessage ?? "Unknown error"},
        requestOptions: e.response!.requestOptions,
      );
    }
    return Response(
      statusCode: 0,
      data: {"message": e.message ?? "Something went wrong"},
      requestOptions: RequestOptions(
        headers: headers,
        baseUrl: url,
      ),
    );
  }

  Future<Response> getData(String path) async {
    try {
      return await _dio
          .get(_baseUrl + path)
          .timeout(const Duration(seconds: 90));
    } on DioException catch (e) {
      return _handleError(e, _baseUrl + path, null);
    }
  }

  Future<Response> postData(
      String path, dynamic body, Map<String, dynamic>? headers) async {
    try {
      return await _dio
          .post(_baseUrl + path,
              data: body, options: Options(headers: headers ?? mainHeaders))
          .timeout(const Duration(seconds: 90));
    } on DioException catch (e) {
      return _handleError(e, _baseUrl + path, headers);
    }
  }

  Future<Response> putData(String path, Map<String, dynamic> body,
      Map<String, dynamic>? headers) async {
    try {
      return await _dio
          .put(_baseUrl + path,
              data: jsonEncode(body),
              options: Options(headers: headers ?? mainHeaders))
          .timeout(const Duration(seconds: 90));
    } on DioException catch (e) {
      return _handleError(e, _baseUrl + path, headers);
    }
  }

  Future<Response> patchData(String path, Map<String, dynamic> body,
      Map<String, dynamic>? headers) async {
    try {
      return await _dio
          .patch(_baseUrl + path,
              data: jsonEncode(body),
              options: Options(headers: headers ?? mainHeaders))
          .timeout(const Duration(seconds: 90));
    } on DioException catch (e) {
      return _handleError(e, _baseUrl + path, headers);
    }
  }

  Future<Response> postFormData(
      String path, dynamic body, Map<String, dynamic>? headers) async {
    try {
      return await _dio
          .post(_baseUrl + path,
              data: body, options: Options(headers: headers ?? mainHeaders))
          .timeout(const Duration(seconds: 90));
    } on DioException catch (e) {
      return _handleError(e, _baseUrl + path, headers);
    }
  }

  Future<Response> deleteData(
      String path, Map<String, dynamic>? headers) async {
    try {
      return await _dio
          .delete(_baseUrl + path,
              options: Options(headers: headers ?? mainHeaders))
          .timeout(const Duration(seconds: 90));
    } on DioException catch (e) {
      return _handleError(e, _baseUrl + path, headers);
    }
  }

  Future<Response> getDataWithParams(String path, Map<String, dynamic>? headers,
      Map<String, dynamic>? params) async {
    try {
      return await _dio
          .get(_baseUrl + path,
              options: Options(headers: headers ?? mainHeaders),
              queryParameters: params)
          .timeout(const Duration(seconds: 90));
    } on DioException catch (e) {
      return _handleError(e, _baseUrl + path, headers);
    }
  }
}
