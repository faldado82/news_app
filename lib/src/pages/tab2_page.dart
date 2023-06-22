import 'package:countries_flag/countries_flag.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/country_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    final articlesByCountry = newsService.obtenerArticlesByCountry?.toList();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaPaises(),
            if (!newsService.isLoading)
              Expanded(
                child: ListaNoticias(noticias: articlesByCountry!),
              ),
            if (newsService.isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.red),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _ListaPaises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countries = Provider.of<NewsService>(context).countries;

    return SizedBox(
      height: 81,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final countryName = countries[index].name;

          return SizedBox(
            width: 75,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  _CountryButton(pais: countries[index]),
                  const SizedBox(height: 5),
                  Consumer<NewsService>(
                    builder: (context, newsService, _) {
                      final selectedCode = newsService.selectedCode;
                      final countryCode = countries[index].code;

                      return Text(
                        '${countryName[0].toUpperCase()}${countryName.substring(1)}',
                        style: TextStyle(
                          color: selectedCode == countryCode
                              ? Colors.red
                              : Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CountryButton extends StatelessWidget {
  final Country pais;
  const _CountryButton({required this.pais});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    final selectedCountryCode = newsService.selectedCode;
    final isSelected = selectedCountryCode == pais.code;

    String flagName = '';

    switch (pais.name.toLowerCase()) {
      case 'argentina':
        flagName = Flags.argentina;
        break;
      case 'brazil':
        flagName = Flags.brazil;
        break;
      case 'venezuela':
        flagName = Flags.venezuela;
        break;
      case 'france':
        flagName = Flags.france;
        break;
      case 'colombia':
        flagName = Flags.colombia;
        break;
      case 'mexico':
        flagName = Flags.mexico;
        break;
      case 'italy':
        flagName = Flags.italy;
        break;
      default:
        flagName = ''; // Ruta vacía si no se encuentra el país
    }

    // final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
        onTap: () {
          final newsService = Provider.of<NewsService>(context, listen: false);
          newsService.selectedCode = pais.code;
        },
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: isSelected ? Colors.redAccent : Colors.black45,
          ),
          child: CountriesFlag(
            flagName,
            height: 40,
            fit: BoxFit.contain,
          ),
        ));
  }
}
