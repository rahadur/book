import 'package:book/providers/app_info_provider.dart';
import 'package:book/providers/book_provider.dart';
import 'package:book/widgets/book_thumbnail.dart';
import 'package:book/widgets/gridview.dart';
import 'package:book/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../config/environment.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  final adUnitId = Environment.admobBannerId;

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  void _loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.fluid,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    final providerAppInfo = Provider.of<AppInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(providerAppInfo.appInfo?.title ?? 'Book App'),
      ),
      body: Consumer<BookProvider>(
        builder: (context, providerBook, child) {
          if (providerBook.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookThumbnail(providerBook.primaryBook),
                          const SectionTitle('Related Books'),
                          GridViewList(providerBook.relatedBook),
                          const SectionTitle('More Books'),
                          GridViewList(providerBook.books),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: AdWidget(ad: _bannerAd),
                ),
              ],
            );
            /* ; */
          }
        },
      ),
    );
  }
}
