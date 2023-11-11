import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatefulWidget {

  final String url;

   const NewsDetailsScreen({
     Key? key,
     required this.url,
   }) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

  final controller = WebViewController();

  @override
  void initState() {
    super.initState();
    webView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo[800],
        title: const Text(
          'News Details',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: WebViewWidget(
        controller:controller,
      ),
    );
  }

  void webView(){
     controller
       .loadRequest(
         Uri.parse(widget.url));
  }
}
