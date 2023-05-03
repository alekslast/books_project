import 'package:flutter/material.dart';

import 'book_model.dart';
import 'database_helper.dart';
import 'book_widget.dart';
import 'add_book_screen.dart';

class LibraryGrid extends StatefulWidget {
  const LibraryGrid({Key? key}) : super(key: key);

  @override
  State<LibraryGrid> createState() => _LibraryGridState();
}

class _LibraryGridState extends State<LibraryGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.grey[200],

        appBar: AppBar(
          title: const Text('Notes'),
          centerTitle: true,
        ),

        floatingActionButton: FloatingActionButton(

          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BookScreen()));
            setState(() {});
          },

          child: const Icon(Icons.add),
        ),
        
        body: FutureBuilder<List<Book>?>(

          future: DatabaseHelper.getAllNotes(),

          builder: (context, AsyncSnapshot<List<Book>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(

                  itemBuilder: (context, index) => BookWidget(
                    book: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookScreen(
                                book: snapshot.data![index],
                              )));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'Are you sure you want to delete this note?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteNote(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                  ),

                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No notes yet'),
              );
            }
            return const SizedBox.shrink();
          },
        )
    );
  }
}