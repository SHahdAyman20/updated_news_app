import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:instant_api_news_app/json_data/article_model.dart';
import 'package:instant_api_news_app/screens/news_webview_details.dart';
import 'package:instant_api_news_app/singleton/shared_prefernces.dart';
import 'package:instant_api_news_app/widgets/items_in_side_bar_drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewsMainScreen extends StatefulWidget {
  const NewsMainScreen({super.key});

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
    initializePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // <-- SEE HERE
        ),
        backgroundColor: Colors.indigo[800],
        title: Text(
          tr(title[currentIndex]),
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w300,
              color: Colors.white),
        ),
      ),
      drawer: ItemsInSideBarDrawer(
        onCountryCodeChanged: (selectedCountryCode) {
          getArticlesByCategory(
            title[currentIndex],
            countryCode: selectedCountryCode,
          );
        },
      ),
      onDrawerChanged: (isOpen) {
        setState(() {});
      },
      body: articleCardListView(),
      bottomNavigationBar: categoriesBottomNavigationBar(),
    );
  }

  Widget articleCardListView() {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        Articles article = articles[index];

        return Container(
          margin: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
              color: Colors.indigo[500],
              borderRadius: BorderRadius.circular(10.sp)),
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.sp),
                      topRight: Radius.circular(15.sp)),
                  child: article.urlToImage.isEmpty
                      ? Align(
                    alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(top: 20.sp),
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 50.sp,

                            ),
                          ),
                      )
                      : Image.network(article.urlToImage),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NewsDetailsScreen(url: article.url)),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: Colors.white,
                        size: 25.sp,
                      )),
                )
              ]),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: Text(
                  tr(article.title),
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              // Text('${articles[index]['description']}')
            ],
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
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.business),
          label: tr('Business'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.biotech),
          label: tr('Technology'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: tr('General'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.sports_basketball),
          label: tr('Sports'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.healing),
          label: tr('Health'),
        ),
      ],
    );
  }

  Future<void> getArticlesByCategory(String category,
      {String? countryCode}) async {
    final response =
        await dio.get('https://newsapi.org/v2/top-headlines', queryParameters: {
      'country': countryCode ?? PreferenceUtils.getString(PrefKeys.newsCountry),
      'category': category,
      'apiKey': '6929a782eeee4868b9bee9e9c6e74f27',
      // 'Language': PreferenceUtils.getString(PrefKeys.language),
    });
    final news = NewsResponse.fromJson(response.data);
    articles = news.articles;
    setState(() {});
  }

  Future<void> initializePreferences() async {
    await PreferenceUtils.init();
    if (PreferenceUtils.getString(PrefKeys.newsCountry) == null) {
      PreferenceUtils.setString(PrefKeys.newsCountry, 'us');
    }
    getArticlesByCategory(title[2]);
  }
}
