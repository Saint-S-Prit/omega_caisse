import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/styles/color.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double placeholderSize;

  const CachedNetworkImageWidget({super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.placeholderSize = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: MediaQuery.of(context).size.width,
        placeholder: (context, url) => Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: appPrincipalColor,
            size: placeholderSize,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

