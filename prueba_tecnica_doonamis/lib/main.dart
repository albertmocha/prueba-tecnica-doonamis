import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/popular_shows_page.dart';
import 'providers/tvshows_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TVShowsProvider()),
      ],
      child: const MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: PopularShowsPage(),
      ),
    );
  }
}
