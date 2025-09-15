import 'package:flutter/material.dart';

import '../../core.dart';

class BgContainer extends StatelessWidget {
  final String? imagePath;
  final bool isVisible;
  final Widget child;
  const BgContainer(
      {super.key, this.imagePath, required this.child, this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: VariableUtilities.theme.primaryColor,
              image: isVisible
                  ? DecorationImage(
                      image: AssetImage(imagePath ?? AssetUtilities.bgImage),
                      fit: BoxFit.cover)
                  : null,
            ),
          ),
          Scaffold(
            backgroundColor: VariableUtilities.theme.transparent,
            resizeToAvoidBottomInset: true,
            body: child,
          ),
        ],
      ),
    );
  }
}
