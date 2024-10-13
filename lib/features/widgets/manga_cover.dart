import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_notes/generated/assets.dart';

class MangaPreviewCover extends StatelessWidget {
  final String? coverUrl;
  final double height;
  final double width;
  final double borderRadius;

  const MangaPreviewCover({
    super.key,
    required this.coverUrl,
    this.width = 110,
    this.borderRadius = 10,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorWidget = Container(
      color: Colors.white,
      child: Image.asset(Assets.images404),
    );

    return Hero(
      tag: coverUrl ?? "error_image",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SizedBox(
          width: width,
          height: height,
          child: CachedNetworkImage(
            imageUrl: coverUrl ?? "",
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => errorWidget,
            placeholder: (_, __) => ColoredBox(color: theme.hintColor),
          ),
        ),
      ),
    );
  }
}
