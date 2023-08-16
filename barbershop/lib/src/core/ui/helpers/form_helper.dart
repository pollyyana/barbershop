
import 'package:flutter/cupertino.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

extension UnfocusExtension on BuildContext{ 
  void unfocus() => Focus.of(this).unfocus(); 
}