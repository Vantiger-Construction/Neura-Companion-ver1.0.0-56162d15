
import 'package:flutter/material.dart';

import 'journal_entry_page.dart';
import 'journal_list_page.dart';
import 'journal_reflection_page.dart';

class JournalRouter {
  static Route<dynamic>? resolvePage(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/journal':
        return MaterialPageRoute(builder: (_) => JournalListPage());
      case '/journal/entry':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => JournalEntryPage(entryId: args));
        }
        return _errorRoute('Missing or invalid entryId');
      case '/journal/reflection':
        return MaterialPageRoute(builder: (_) => JournalReflectionPage());
      default:
        return _errorRoute('Unknown journal route');
    }
  }

  static Route<dynamic> _errorRoute(String msg) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('Journal Error')),
        body: Center(child: Text('Routing Error: \$msg')),
      ),
    );
  }
}
