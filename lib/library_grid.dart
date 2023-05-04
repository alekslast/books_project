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

  List<Book> bookList = [];

  @override
  Widget build(BuildContext context) {

    // void showAddBookDialog() {
    //   showDialog(
    //     context: context,
    //     builder: (_) {
    //       return AlertDialog(
    //         content: 
    //         AddBookScreen(
    //           toCreate: (item) {
    //             bookList.add(item);
    //           },
          
    //           toUpdate: (item) {},
    //         ),
            
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //       );
    //     }
    //   );
    // }

    return Scaffold(

        extendBody: true,
        backgroundColor: Colors.grey,

        appBar: AppBar(
        leading: const Icon(Icons.book),
        title: const Text('Cultivate'),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.search)
          ),
        ],
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
                return GridView.builder(

                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 4/5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),

                  

                  itemBuilder: (context, index) {

                    final bookItem = snapshot.data![index];

                    return BookWidget(
                      book: bookItem,
                      onTap: () async {

                        // showDialog(
                        //   context: context,
                        //   builder: (_) {
                        //     return AlertDialog(
                        //       content: 
                        //       AddBookScreen(
                        //         book: bookItem,
                        //         toUpdate: (bookItem) {
                        //           snapshot.data![index]  = bookItem;
                        //         },
                            
                        //         toCreate: (bookItem) {},
                        //       ),
                              
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //     );
                        //   }
                        // );

                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddBookScreen(
                                  book: bookItem,
                                  toUpdate: (bookItem) {
                                    snapshot.data![index]  = bookItem;
                                  },
                                  toCreate: (bookItem) {},
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
                          },
                        );
                      },
                    
                    );
                  },

                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No notes yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ),


      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.amber,

        onPressed: 
        // showAddBookDialog,
        () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookScreen(
                toCreate: (item) {
                  bookList.add(item);
                },
          
                toUpdate: (item) {},
              )
            )
          );
          setState(() {});
        },

        child: const Icon(Icons.add),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

    );
  }
}