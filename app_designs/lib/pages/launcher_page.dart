import 'package:app_designs/routes/routes.dart';
import 'package:app_designs/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatelessWidget {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diseños en Flutter")),
      body: _ListaOpciones(),
      drawer: _MenuPrincipal(),
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  const _ListaOpciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return ListView.separated(
      itemCount: pageRoutes.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) =>
          Divider(color: appTheme.primaryColorLight),
      itemBuilder: (context, index) => ListTile(
        leading: FaIcon(pageRoutes[index].icon,
            color: appTheme.colorScheme.secondary),
        title: Text(pageRoutes[index].titulo),
        trailing:
            Icon(Icons.chevron_right, color: appTheme.colorScheme.secondary),
        onTap: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => pageRoutes[index].page));
        },
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  const _MenuPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.colorScheme.secondary;

    return Drawer(
      child: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: accentColor,
                  child: const Text("BH", style: TextStyle(fontSize: 30)),
                ),
              ),
            ),
            const Expanded(child: _ListaOpciones()),
            ListTile(
              leading: Icon(Icons.lightbulb_outline, color: accentColor),
              title: const Text("Dark Mode"),
              trailing: Switch.adaptive(
                  value: appTheme.darkTheme,
                  activeColor: accentColor,
                  onChanged: (value) => appTheme.darkTheme = value),
            ),
            SafeArea(
              top: false,
              left: false,
              right: false,
              bottom: true,
              child: ListTile(
                leading: Icon(Icons.add_to_home_screen, color: accentColor),
                title: const Text("Custom Theme"),
                trailing: Switch.adaptive(
                    value: appTheme.customTheme,
                    activeColor: accentColor,
                    onChanged: (value) => appTheme.customTheme = value),
              ),
            )
          ],
        ),
      ),
    );
  }
}
