import 'package:book/models/book.dart';
import 'package:book/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookThumbnail extends StatelessWidget {
  final Book? book;
  const BookThumbnail(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    if (book == null) return const SizedBox.shrink();
    final providerBook = Provider.of<BookProvider>(context);
    return Center(
      child: GestureDetector(
        onTap: () {
          if (book != null) {
            providerBook.selectBook(book!);
            Navigator.pushNamed(context, '/details');
          }
        },
        child: Column(
          children: [
            FadeInImage(
              image: NetworkImage(book!.thumbnail),
              width: 200.0,
              placeholder: const AssetImage("assets/images/placeholder.png"),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/placeholder.png',
                    fit: BoxFit.fitWidth);
              },
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 16),
            Text(
              book!.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Scala',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              text: TextSpan(
                text: 'by ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: book?.author.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
