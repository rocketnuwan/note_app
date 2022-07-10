import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/views/note_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Note App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const NoteView(),
    );
  }
}
