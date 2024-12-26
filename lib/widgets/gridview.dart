import 'package:book/models/book.dart';
import 'package:book/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridViewList extends StatelessWidget {
  final List<Book> books;
  const GridViewList(this.books, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 220,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GridItem(books[index]);
            },
            childCount: books.length,
          ),
        )
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final Book book;
  const GridItem(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final providerBook = Provider.of<BookProvider>(context);
    return GestureDetector(
      onTap: () {
        providerBook.selectBook(book);
        Navigator.pushNamed(context, '/details');
      },
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FadeInImage(
                image: NetworkImage(book.thumbnail),
                height: 172,
                placeholder: const AssetImage("assets/images/placeholder.png"),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/placeholder.png',
                      fit: BoxFit.fitWidth);
                },
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              book.author.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
