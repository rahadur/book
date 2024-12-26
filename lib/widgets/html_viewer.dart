import 'package:book/providers/text_formate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class HtmlViewer extends StatefulWidget {
  final String htmlContent;
  const HtmlViewer(this.htmlContent, {super.key});

  @override
  State<HtmlViewer> createState() => _HtmlViewerState();
}

class _HtmlViewerState extends State<HtmlViewer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TextFormateProvider>(builder: (context, value, child) {
      return Container(
        height: MediaQuery.of(context).size.height,
        color: value.backgroundColor,
        child: SingleChildScrollView(
          child: Html(
            data: widget.htmlContent,
            style: {
              "html": Style(
                color: value.textColor,
                backgroundColor: value.backgroundColor,
                fontSize: FontSize(value.fontSize),
                fontFamily: value.fontFamily,
                textAlign: value.textAlign,
                lineHeight: LineHeight(value.lineHeight),
                padding: HtmlPaddings(
                  left: HtmlPadding(16),
                  right: HtmlPadding(16),
                  bottom: HtmlPadding(16),
                ),
              ),
            },
          ),
        ),
      );
    });
  }
}
