import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

// para mantener el estado cuando se vuelve desde otra pagina, debemos usar un AutomaticKeepAliveClientMixin, esto hara que al volver desde otra pagina se mantenga en el lugar que se dejo y no vuelva al comienzo de la pantalla.
// Para ello debemos pasar a Stateful Widget y poner with AutomaticKeepAliveClientMixin en la class correspondiente
// esto hara saltar un error, se debe a que debemos crear un override mas
// en el override solo sera necesario poner true y listo, sucede la magia.
// tambien debemos tener cuenta de la advertencia de crear un super.build(context)

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headlines.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : ListaNoticias(noticias: newsService.headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
