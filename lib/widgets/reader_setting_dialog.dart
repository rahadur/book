import 'package:book/providers/content_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReaderSettingsDialog extends StatelessWidget {
  const ReaderSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final sectionProvider = Provider.of<ContentProvider>(context);

    return AlertDialog(
      title: const Text('Reader Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Font Size'),
          Slider(
            value: sectionProvider.fontSize,
            min: 12,
            max: 30,
            onChanged: (value) {
              sectionProvider.setFontSize(value);
            },
          ),
          const Text('Background Color'),
          Row(
            children: [
              _buildColorButton(context, Colors.white, sectionProvider),
              _buildColorButton(context, Colors.black, sectionProvider),
              _buildColorButton(context, Colors.grey, sectionProvider),
              _buildColorButton(context, Colors.brown, sectionProvider),
            ],
          ),
          const Text('Text Alignment'),
          Row(
            children: [
              _buildAlignButton(context, TextAlign.left, sectionProvider),
              _buildAlignButton(context, TextAlign.center, sectionProvider),
              _buildAlignButton(context, TextAlign.right, sectionProvider),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildColorButton(
      BuildContext context, Color color, ContentProvider provider) {
    return IconButton(
      icon: Icon(Icons.circle, color: color),
      onPressed: () {
        provider.setBackgroundColor(color);
      },
    );
  }

  Widget _buildAlignButton(
      BuildContext context, TextAlign align, ContentProvider provider) {
    return IconButton(
      icon: const Icon(Icons.format_align_left), // Change icon based on align
      onPressed: () {
        provider.setTextAlign(align);
      },
    );
  }
}
