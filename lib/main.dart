import 'package:flutter/material.dart';
import 'package:isar_offline_database_notes_app/models/note_database.dart';
import 'package:isar_offline_database_notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages/notes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => NoteDatabase()),
     ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
     
    ),
    ],
     child: MyApp(),
  
    )
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themedata,
    );
  }
}
