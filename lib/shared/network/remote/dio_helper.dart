import 'package:dio/dio.dart';

class dioHelper{

  static Dio dio =Dio();

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }
      )
    );
  }

  static Future<Response>getData({
    required String url,
     Map<String, dynamic>? query,
    String? token,

})  async
 {
   dio.options.headers = {
     "Authorization" : token?? ''
   };
    return await dio.get(
        url ,
      queryParameters: query?? {} ,
    );
  }

  static Future<Response> postData({
    required String url,
     Map<String , dynamic>? query,
    required Map<String , dynamic> data,
    String? token,

})async
  {
    dio.options.headers = {
      "Authorization" : token,
    };
     return await dio.post(
       url,
       queryParameters: query,
       data: data,
     );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic>? query,
    String? token,
  })async
  {
    dio.options.headers = {

        'Content-Type': 'application/json',
      "Authorization" : token?? ''
    };

    return await dio.put(
      url ,
      data: query
    );
  }

  static Future<Response>DeleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
}) async
  {
    dio.options.headers = {

      'Content-Type': 'application/json',
      "Authorization" : token?? ''
    };

    return await dio.delete(
        url ,
      queryParameters: query,
      data: data,
    );
  }

}