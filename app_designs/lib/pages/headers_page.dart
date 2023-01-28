import 'package:app_designs/theme/theme.dart';
import 'package:app_designs/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadersPage extends StatelessWidget {
  const HeadersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accentColor =
        Provider.of<ThemeChanger>(context).currentTheme.colorScheme.secondary;
    return Scaffold(body: HeaderOndas(color: accentColor));
  }
}
