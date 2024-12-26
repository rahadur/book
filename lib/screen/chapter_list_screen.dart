import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../config/environment.dart';
import '../widgets/chapter_list.dart';



class ChapterListScreen extends StatefulWidget {
  const ChapterListScreen({super.key});

  final bannerAdUnitId = Environment.admobBannerId;

  @override
  State<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadBannerAd() {
    BannerAd(
      adUnitId: widget.bannerAdUnitId,
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
    //final chapterProvider = Provider.of<ChapterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapters'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChapterList(),
          ),
          if (_bannerAd != null)
            SizedBox(height: 60, child: AdWidget(ad: _bannerAd!))
        ],
      ),
    );
  }
}
