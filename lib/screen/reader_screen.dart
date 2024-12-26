import 'package:book/models/content.dart';
import 'package:book/providers/content_provider.dart';
import 'package:book/widgets/html_viewer.dart';
import 'package:book/widgets/text_formate.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../config/environment.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});
  final adUnitId = Environment.admobBannerId;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  ChapterContent? _content;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _content =
        Provider.of<ContentProvider>(context, listen: false).selectedSection;
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_content?.title ?? ''),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (_content == null) {
      return const Center(child: Text('No section selected'));
    }
    return Column(
      children: [
        Expanded(
          child: ReaderViewer(content: _content?.content ?? ''),
        ),
        if (_bannerAd != null)
          SizedBox(height: 50, child: AdWidget(ad: _bannerAd!))
      ],
    );
  }
}

class ReaderViewer extends StatefulWidget {
  final String content;

  const ReaderViewer({super.key, required this.content});

  @override
  State<ReaderViewer> createState() => _ReaderViewerState();
}

class _ReaderViewerState extends State<ReaderViewer> {
  bool showTextFormate = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showTextFormate = !showTextFormate;
            });
          },
          child: HtmlViewer(widget.content),
        ),
        if (showTextFormate) const TextFormat(),
      ],
    );
  }
}
