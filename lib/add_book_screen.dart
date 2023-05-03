import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'book_model.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({
    super.key,
    this.book,
  });

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

      appBar: AppBar(
        title: Text( book == null ? 'Add a note': 'Edit note'), //title
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'What are you thinking about?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: TextFormField(
                controller: booknameController,
                maxLength: 1,
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

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}