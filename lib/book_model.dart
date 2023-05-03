class Book {
  const Book({
    required this.bookname,
    required this.author,
    this.id,
  });

  final int? id;
  final String bookname;
  final String author;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json['id'],
    bookname: json['bookname'],
    author: json['author'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bookname': bookname,
    'author': author,
  };
}