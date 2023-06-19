import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';

const String _urlNewsDomain = 'https://newsapi.org/v2';
const String _apiKey = 'fa2c9f63199e4379a5637cfb302d97a4';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.businessTime, 'bussines'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    for (var item in categories) {
      categoryArticles[item.name] = []; //List<Article>.empty();
    }
  }

  // Getter & Setter - Category
  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  // Get top headlines
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


  // Get articles by Category
  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final String url =
        '$_urlNewsDomain/top-headlines?apiKey=$_apiKey&category=$category&country=us';

    final response = await http.get(Uri.parse(url));
    final newsResponse = newsResponseFromJson(response.body);
    categoryArticles[category]!.addAll(newsResponse.articles);

    notifyListeners();
  }
}
