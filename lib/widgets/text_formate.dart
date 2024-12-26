import 'package:book/providers/text_formate_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormat extends StatefulWidget {
  const TextFormat({super.key});

  @override
  State<TextFormat> createState() => _TextFormatState();
}

class _TextFormatState extends State<TextFormat> {
  final List<String> items = [
    /*  'Contemporary',
    'Geometric',
    'Modern',
    'Postmodern',
    'Slab',
    'Vintage',
    'Regular', */
    'Scala',
    'Din Offc Pro',
    'Harriet Text',
    'Scala Sans Pro',
    'Tisa Offc Pro',
    'Vollkorn',
    'Livory',
  ];
  final List<double> fontSize = [14, 16, 18, 20, 22];
  final List<Color> colors = [
    const Color(0xFFFFFFFF),
    const Color(0xFFF5E9D3),
    const Color(0xFF333333),
    const Color(0xFF121212)
  ];

  final List<Color> textColors = [
    const Color(0xFF111724),
    const Color(0xFF0d0d0d),
    const Color(0xFF828282),
    const Color(0xFFEDEEF2)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.white,
      child: Consumer<TextFormateProvider>(
        builder: (context, providerText, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PopupMenuButton(
                initialValue: providerText.fontFamily,
                icon: const Icon(Icons.text_format),
                onSelected: (String value) {
                  switch (value) {
                    case 'Scala':
                      providerText.selectFontFamily('Scala');
                      break;
                    case 'Din Offc Pro':
                      providerText.selectFontFamily('Din Offc Pro');
                      break;
                    case 'Harriet Text':
                      providerText.selectFontFamily('Harriet Text');
                      break;
                    case 'Scala Sans Pro':
                      providerText.selectFontFamily('Scala Sans Pro');
                      break;
                    case 'Tisa Offc Pro':
                      providerText.selectFontFamily('Tisa Offc Pro');
                      break;
                    case 'Vollkorn':
                      providerText.selectFontFamily('Vollkorn');
                      break;
                    case 'Livory':
                      providerText.selectFontFamily('Livory');
                      break;
                    default:
                      providerText.selectFontFamily('');
                      break;
                  }
                },
                itemBuilder: (context) => items
                    .map((String size) => PopupMenuItem<String>(
                          value: size,
                          child: Text(size),
                        ))
                    .toList(),
              ),
              PopupMenuButton<double>(
                initialValue: providerText.fontSize,
                icon: const Icon(Icons.text_fields),
                onSelected: (double size) {
                  // Handle the selected value
                  providerText.selectFontSize(size);
                },
                itemBuilder: (context) => fontSize
                    .map((double size) => PopupMenuItem<double>(
                          value: size,
                          child: Text('$size'),
                        ))
                    .toList(),
              ),
              IconButton(
                icon: const Icon(Icons.format_align_left),
                isSelected: TextAlign.left == providerText.textAlign,
                onPressed: () {
                  providerText.selectTextAlgn(TextAlign.left);
                },
              ),
              IconButton(
                icon: const Icon(Icons.format_align_justify),
                isSelected: TextAlign.justify == providerText.textAlign,
                onPressed: () {
                  providerText.selectTextAlgn(TextAlign.justify);
                },
              ),
              IconButton(
                icon: const Icon(Icons.density_small),
                isSelected: providerText.lineHeight == 1.5,
                onPressed: () {
                  providerText.selectLineHeight(1.5);
                },
              ),
              IconButton(
                icon: const Icon(Icons.density_medium),
                isSelected: providerText.lineHeight == 1.7,
                onPressed: () {
                  providerText.selectLineHeight(1.7);
                },
              ),
              IconButton(
                icon: const Icon(Icons.density_large),
                isSelected: providerText.lineHeight == 1.9,
                onPressed: () {
                  providerText.selectLineHeight(1.9);
                },
              ),
              PopupMenuButton(
                initialValue: providerText.backgroundColor,
                icon: const Icon(Icons.format_color_fill),
                onSelected: (Color color) {
                  if (color == colors[1]) {
                    providerText.selectBackground(color, textColors[1]);
                  } else if (color == colors[2]) {
                    providerText.selectBackground(color, textColors[2]);
                  } else if (color == colors[3]) {
                    providerText.selectBackground(color, textColors[3]);
                  } else {
                    providerText.selectBackground(color, textColors[0]);
                  }
                },
                itemBuilder: (context) {
                  var index = 0;
                  return colors.map((Color color) {
                    var colorName = '';
                    switch (index) {
                      case 1:
                        colorName = 'Paper';
                        break;
                      case 2:
                        colorName = 'Grey';
                        break;
                      case 3:
                        colorName = 'Dark';
                        break;
                      default:
                        colorName = 'White';
                        break;
                    }
                    var item = PopupMenuItem<Color>(
                      value: color,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: color,
                          ),
                          const SizedBox(width: 8),
                          Text(colorName)
                        ],
                      ),
                    );
                    index++;
                    return item;
                  }).toList();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
