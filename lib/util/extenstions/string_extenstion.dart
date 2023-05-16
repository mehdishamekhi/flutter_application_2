import 'dart:ui';

extension Colorparsing on String {
  Color parsetocolor() {
    String colorstring = 'FF$this';
    int hexcolor = int.parse(colorstring, radix: 16);
    return Color(hexcolor);
  }
}
