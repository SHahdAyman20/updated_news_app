import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instant_api_news_app/json_data/article_model.dart';
import 'package:instant_api_news_app/screens/news_webview_details.dart';
import 'package:instant_api_news_app/singleton/shared_prefernces.dart';
import 'package:instant_api_news_app/widgets/items_in_side_bar_drawer.dart';

class NewsMainScreen extends StatefulWidget {
  const NewsMainScreen({Key? key});

  @override
  State<StatefulWidget> createState() {
    return NewsMainScreenState();
  }
}

class NewsMainScreenState extends State<NewsMainScreen> {
  int currentIndex = 2;
  List<Articles> articles = [];
  final dio = Dio();

  final List<String> title = [
    'Business',
    'Technology',
    'General',
    'Sports',
    'Health',
  ];

  @override
  void initState() {
    super.initState();
    // if(PreferenceUtils.getString(PrefKeys.newsCountry).isEmpty){
    //   PreferenceUtils.setString(PrefKeys.newsCountry, 'us');
    // }
    getArticlesByCategory(title[2]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo[800],
        title: Text(
          '${title[currentIndex]} News',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      drawer: const ItemsInSideBarDrawer(),
      body: articleCardListView(),
      bottomNavigationBar: categoriesBottomNavigationBar(),
    );
  }


  Widget articleCardListView() {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        Articles article = articles[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      NewsDetailsScreen(url: article.url)),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.indigo[500],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: article.urlToImage.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                          ),
                        )
                      : Image.network(article.urlToImage),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    article.title,
                    style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text('${articles[index]['description']}')
              ],
            ),
          ),
        );
      },
    );
  }

  Widget categoriesBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.indigo[800],
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey[400],
      currentIndex: currentIndex,
      selectedIconTheme: const IconThemeData(size: 37),
      onTap: (selectedIndex) {
        setState(() {
          currentIndex = selectedIndex;
          getArticlesByCategory(title[currentIndex]);
        });
      },
      iconSize: 24,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.biotech),
          label: 'Technology',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'General',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_basketball),
          label: 'Sports',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.healing),
          label: 'Health',
        ),
      ],
    );
  }

  Future<void> getArticlesByCategory(String category) async {
    final response =
        await dio.get('https://newsapi.org/v2/top-headlines', queryParameters: {
      'country': PreferenceUtils.getString(PrefKeys.newsCountry),
      'category': category,
      'apiKey': '6929a782eeee4868b9bee9e9c6e74f27'
    });
    if (response.data != null) {
      final news = NewsResponse.fromJson(response.data);
      articles = news.articles;
      print('.-.-.-.-.->$articles');
      setState(() {});
    }
  }
}
