import 'package:flutter/widgets.dart';

double convertFigmaPxToDp(BuildContext context, double figmaPx) {
  // Get the device's pixel ratio
  double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

  // Convert Figma pixel size to logical pixels (dp)
  double dpSize = figmaPx / devicePixelRatio;

  return dpSize;
}
