// This is the UI

import 'package:flutter/material.dart';

import 'add_book_screen.dart';
import 'book_model.dart';

class BookWidget extends StatelessWidget{
  const BookWidget({
    Key? key,
    required this.book,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  final Book book;
  final VoidCallback onTap;
  final VoidCallback onLongPress;


  @override
  Widget build(BuildContext context) {

    const backgroundImage = 'assets/images/bulgakov.jpg';
    List<Book> bookList = [];

    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),


      child: 
      // AlertDialog(
      //   content: AddBookScreen(
      //     toCreate: (item) {
      //       bookList.add(item);
      //     },

      //     toUpdate: (item) {},
      //   ),

      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      // ),

      Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }  
}