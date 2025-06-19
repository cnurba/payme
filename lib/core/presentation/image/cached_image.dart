import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:payme/core/http/endpoints.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = Container(
      padding: EdgeInsets.only(right: 8),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Colors.green, width: 2)),
      ),
      child: CachedNetworkImage(
        imageUrl: "${Endpoints.image}$imageUrl",
        scale: 0.5,
        width: width,
        height: height,
        fit: fit,
        placeholder:
            (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}
