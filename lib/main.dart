import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jobstd_flutter/page/poststd.dart';
import 'package:provider/provider.dart';
import 'package:jobstd_flutter/page/loginstd.dart';
import 'package:jobstd_flutter/providers/user_provider.dart';
import 'package:jobstd_flutter/page/webstd.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: WebstdPage(),
      home: LoginstdPage(),
      routes: {
        
        '/login': (context) => LoginstdPage(),
      }),
    );
  }
}