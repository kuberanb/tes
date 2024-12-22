import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes/views/filter/filter_screen.dart';
import 'package:tes/view_models/filter/filter_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FilterViewModel>(
            create: (context) => FilterViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Filter',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const FilterScreen(),
      ),
    );
  }
}
