import 'package:admin_dashboard/atendidos/atendidos.page.dart';
import 'package:admin_dashboard/para_atender/para_atender.page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool expandedMenu = MediaQuery.of(context).size.width > 1000;
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              if (index != _selectedIndex) {
                setState(() {
                  _selectedIndex = index;
                });
                switch (index) {
                  case 0:
                    _navigatorKey.currentState!.pushReplacementNamed("/");
                    break;
                  default:
                    _navigatorKey.currentState!.pushReplacementNamed(
                      "/atendidos",
                    );
                }
              }
            },
            extended: expandedMenu,
            labelType: expandedMenu
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.selected,
            minExtendedWidth: 200,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.paste),
                label: Text('Atendimentos'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.check),
                label: Text('Atendidos'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: (RouteSettings routeSettings) {
                switch (routeSettings.name) {
                  case "/":
                    return MaterialPageRoute(
                      builder: (context) => const ParaAtenderPage(),
                    );

                  case "/atendidos":
                    return MaterialPageRoute(
                      builder: (context) => const AtendidosPage(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
