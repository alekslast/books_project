import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'book_model.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({
    super.key,
    required this.toCreate,
    required this.toUpdate,
    this.book,
  });

  final Function(Book) toCreate;
  final Function(Book) toUpdate;

  final Book? book;

  @override
  Widget build(BuildContext context) {

    final booknameController = TextEditingController();
    final authorController = TextEditingController();

    if (book != null) {
      booknameController.text = book!.bookname;
      authorController.text = book!.author;
    }

    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          const Text(
            'What are you thinking about?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          TextFormField(
            controller: booknameController,
            decoration: const InputDecoration(
              hintText: 'Title',
              labelText: 'Note title',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 0.75,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )
              )
            ),
          ),

          TextFormField(
            controller: authorController,
            decoration: const InputDecoration(
              hintText: 'Type here the note',
              labelText: 'Note description',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 0.75,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            keyboardType: TextInputType.multiline,
            onChanged: (str) {},
            maxLines: 5,
          ),

          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(

              onPressed: () async {

                final bookname = booknameController.value.text;
                final author = authorController.value.text;

                if (bookname.isEmpty || author.isEmpty) {
                  return;  // Basically means we stop our code here. Returns nothing. Simillar to break
                }

                final Book model = Book(
                  bookname: bookname,
                  author: author,
                  id: book?.id,
                );

                if (book == null) {
                  await DatabaseHelper.addNote(model);
                } else {
                  await DatabaseHelper.updateNote(model);
                }

                Navigator.pop(context);
              },

              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 0.75,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )
                  )
                ),
              ),

              child: Text(
                book == null ? 'Save' : 'Edit',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },

              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 0.75,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )
                  )
                ),
              ),

              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 19),
              ),
            ),
          ),
        ],
      ),
    );
  }
}