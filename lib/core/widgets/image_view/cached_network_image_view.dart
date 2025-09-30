import 'package:cached_network_image/cached_network_image.dart';
import 'package:geopay/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class CachedNetworkImageView extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CachedNetworkImageView({
    super.key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl.contains(APIUtilities.imagePrefix)
          ? imageUrl
          : "${APIUtilities.imagePrefix}${imageUrl.contains('/') ? imageUrl : '/$imageUrl'}",
      height: height,
      width: width,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CupertinoActivityIndicator(
          color: VariableUtilities.theme.primaryColor,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
