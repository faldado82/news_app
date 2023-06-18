import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual, // elemento seleccionado
        onTap: (i) => navegacionModel.paginaActual = i,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Para ti'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezado')
        ]);
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,

      // efecto de rebote para 1era y ultima pagina
      // physics: const BouncingScrollPhysics(),

      // efecto SIN rebote en 1era y ultima pagina
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const Tab1Page(),
        
        Container(color: Colors.green),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual; // ya no es necesario el this

  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
