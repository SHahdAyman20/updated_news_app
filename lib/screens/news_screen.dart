// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:instant_api_news_app/json_data/article_model.dart';
// import 'package:instant_api_news_app/screens/news_webview_details.dart';
//
// class NewsScreen extends StatefulWidget {
//   const NewsScreen({Key? key, required this.category}) : super(key: key);
//
//   final String category;
//
//
//   @override
//   State<NewsScreen> createState() => _NewsScreenState();
// }
//
// class _NewsScreenState extends State<NewsScreen> {
//   List<Articles> articles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getArticlesByCategory(widget.category);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: articles.length,
//         itemBuilder: (context, index) {
//
//           Articles article = articles[index];
//
//           return GestureDetector(
//             onTap: (){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute (
//                 builder: (BuildContext context) =>
//                     NewsDetailsScreen(url: article.url)
//               ),);
//             },
//             child: Container(
//               margin: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.indigo[500],
//                   borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 children: [
//                   ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10)),
//                       child: article.urlToImage.isEmpty
//                           ? const Padding(
//                               padding: EdgeInsets.only(top: 20),
//                               child: Icon(
//                                 Icons.image_not_supported_outlined,
//                                 size: 50,
//                               ),
//                             )
//                           : Image.network(article.urlToImage),),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(
//                       article.title,
//                       style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   // Text('${articles[index]['description']}')
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> getArticlesByCategory(String category) async {
//     final dio = Dio();
//     final response =
//         await dio.get('https://newsapi.org/v2/top-headlines', queryParameters: {
//       'country': 'us',
//       'category': category,
//       'apiKey': '6929a782eeee4868b9bee9e9c6e74f27'
//     });
//     final news = NewsResponse.fromJson(response.data);
//     articles = news.articles;
//     setState(() {});
//   }
// }
