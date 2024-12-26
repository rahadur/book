import 'package:book/config/environment.dart';
import 'package:book/models/book.dart';
import 'package:book/providers/book_provider.dart';
import 'package:book/widgets/book_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final book = bookProvider.selectedBook;

    return Scaffold(
      appBar: AppBar(title: Text(book?.title ?? '')),
      body: book == null
          ? const Center(child: Text('No book selected'))
          : BookDetails(book: book),
    );
  }
}

class BookDetails extends StatefulWidget {
  final Book book;
  final adUnitId = Environment.admobBannerId;

  const BookDetails({
    super.key,
    required this.book,
  });

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    BannerAd(
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      size: AdSize.fluid,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  BookThumbnail(widget.book),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 16),
                    child: SizedBox(
                      width: double.infinity, // Full width
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/chapters');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade500,
                        ),
                        child: const Text(
                          'Read Book',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Html(
                    data: widget.book.description,
                    style: {
                      'html': Style(
                        fontSize: FontSize(18),
                        fontFamily: 'Scala',
                        color: const Color(0xFF515e70),
                      )
                    },
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
        if (_bannerAd != null)
          SizedBox(height: 50, child: AdWidget(ad: _bannerAd!))
      ],
    );
  }
}
