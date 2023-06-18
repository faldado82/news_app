import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/src/models/news_models.dart';

const String _urlNewsDomain = 'https://newsapi.org/v2';
const String _apiKey = 'fa2c9f63199e4379a5637cfb302d97a4';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() async {
    const String url =
        '$_urlNewsDomain/top-headlines?country=us&apiKey=$_apiKey';
    final response = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(response.body);

    // agregamos todos los articulos de noticias a nuestro array de headlines
    // que definimos previamente
    headlines.addAll(newsResponse.articles);

    // notificamos a los Listeners para redibujar los widgets necesarios
    notifyListeners();
  }
}
