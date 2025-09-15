import 'package:flutter/material.dart';

import '../../core.dart';

extension DropDownList<T> on List<T> {
  List<DropdownMenuItem<T>> dropDownItem(String Function(T element) name,
      {double fontSize = 10, Color? textColor}) {
    return map(
      (e) => DropdownMenuItem<T>(
        value: e,
        child: Text(
          name.call(e),
          style: FontUtilities.style(
            fontSize: fontSize,
            fontColor: textColor ?? VariableUtilities.theme.thirdColor,
            fontWeight: FWT.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ).toList();
  }

  String toName(String Function(T e) name) {
    return map((e) => name.call(e)).join(",");
  }
}
