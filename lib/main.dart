import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'library_grid.dart';

void main() {
  runApp(const MyApp());
}



// final _router = GoRouter(
//   initialLocation: '/',
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const LibraryGrid(),
//     )
//   ]
// );



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    // MaterialApp.router(

    //   routerConfig: _router,

      title: 'Flutter Local Database demo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LibraryGrid(),

    );
  }
}