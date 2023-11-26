// if i wanna make dio singleton



//
// import 'package:dio/dio.dart';
// import 'package:instant_api_news_app/singleton/shared_prefernces.dart';
//
// class AppDio {
//
//   static late Dio _dio;
//
//   static void init(){
//     BaseOptions baseOptions = BaseOptions(
//       baseUrl: 'https://newsapi.org/v2/top-headlines',
//     );
//     _dio = Dio(baseOptions);
//   }
//
//   static Future getData({required String? category,required String? countryCode}) async{
//     final response = await _dio.get(
//       '',
//       queryParameters: {
//         'country': countryCode ?? PreferenceUtils.getString(PrefKeys.newsCountry),
//         'category': category,
//         'apiKey': '6929a782eeee4868b9bee9e9c6e74f27',
//       },
//     );
//     return response.data['articles'];
//   }
// }
