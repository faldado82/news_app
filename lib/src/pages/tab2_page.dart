import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [Expanded(child: _ListaCategorias())],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Icon(categories[index].icon),
                const SizedBox(height: 5),
                Text(categories[index].name)
              ],
            ));
      },
    );
  }
}
