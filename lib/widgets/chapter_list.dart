import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:book/models/content.dart';
import 'package:book/providers/chapter_provider.dart';
import 'package:book/providers/content_provider.dart';

import '../config/environment.dart';

class ChapterList extends StatelessWidget {
  final _interstitialAdId = Environment.admobInterstitialId;

  const ChapterList({super.key});

  void _openReader(context) async {
    final preferences = await SharedPreferences.getInstance();
    var count = preferences.getInt('Interstitial') ?? 0;

    if (count < 5) {
      count += 1;
      preferences.setInt('Interstitial', count);
      debugPrint('Increase Interstitial Ad Count: $count');
      Navigator.pushNamed(context, '/reader');
    } else {
      InterstitialAd.load(
        adUnitId: _interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                debugPrint('Ad dismissed full screenContent');
                Navigator.pushNamed(context, '/reader').whenComplete(() {
                  preferences.setInt('Interstitial', 1);
                  debugPrint('Reset Interstitial Ad Count');
                });
              },
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
            );
            // Show Interstitial
            ad.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
            Navigator.pushNamed(context, '/reader');
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChapterProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: value.chapters.length,
          itemBuilder: (context, index) {
            final chapter = value.chapters[index];
            if (!chapter.sectionable) {
              return ListTile(
                title: Text(chapter.title),
                onTap: () {
                  Provider.of<ContentProvider>(context, listen: false)
                      .selectSection(
                    ChapterContent(
                      title: chapter.title,
                      content: chapter.content,
                    ),
                  );

                  // Show Interstitial Ad or Navigate to Reader.
                  _openReader(context);
                },
              );
            } else {
              return ExpansionTile(
                title: Text(chapter.title),
                children: chapter.contents.map((section) {
                  return ListTile(
                    title: Text(section.title),
                    onTap: () {
                      Provider.of<ContentProvider>(context, listen: false)
                          .selectSection(section);

                      // Show Interstitial Ad or Navigate to Reader.
                      _openReader(context);
                    },
                  );
                }).toList(),
              );
            }
          },
        );
      },
    );
  }
}
