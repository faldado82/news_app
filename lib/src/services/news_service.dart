import 'package:countries_flag/countries_flag.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:news_app/src/models/country_model.dart';
import 'package:news_app/src/models/news_models.dart';

const String _urlNewsDomain = 'https://newsapi.org/v2';
const String _apiKey = 'fa2c9f63199e4379a5637cfb302d97a4';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCode = 'ar';

  List<Country> countries = [
    Country(CountriesFlag(Flags.argentina), 'argentina', 'ar'),
    Country(CountriesFlag(Flags.brazil), 'brazil', 'br'),
    Country(CountriesFlag(Flags.venezuela), 'venezuela', 've'),
    Country(CountriesFlag(Flags.france), 'france', 'fr'),
    Country(CountriesFlag(Flags.colombia), 'colombia', 'co'),
    Country(CountriesFlag(Flags.mexico), 'mexico', 'mx'),
    Country(CountriesFlag(Flags.italy), 'italy', 'it'),
  ];

  Map<String, List<Article>> categoryArticles = {};
  Map<String, List<Article>> countryArticles = {};

  NewsService() {
    getTopHeadlines();
    for (var item in countries) {
      countryArticles[item.code] = []; //List<Article>.empty();
    }
  }

  // Getter & Setter - Country
  String get selectedCode => _selectedCode;
  set selectedCode(String valor) {
    _selectedCode = valor;
    getArticlesByCountry(valor);
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

  List<Article>? get obtenerArticlesByCountry => countryArticles[selectedCode];

  getArticlesByCountry(String country) async {
    if (countryArticles.containsKey(country) &&
        countryArticles[country]!.isNotEmpty) {
      return countryArticles[country];
    }

    final String url =
        '$_urlNewsDomain/top-headlines?apiKey=$_apiKey&country=$country';

    final response = await http.get(Uri.parse(url));
    final newsResponse = newsResponseFromJson(response.body);

    if (countryArticles.containsKey(country)) {
      countryArticles[country]!.addAll(newsResponse.articles);
    } else {
      countryArticles[country] = newsResponse.articles;
    }
    notifyListeners();
  }
}
