import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final double radius;
  final String? imageurl;
  const CachedImage({
    super.key,
    this.imageurl,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageurl ??
            'https://www.google.com/url?sa=i&url=https%3A%2F%2Fimglarger.com%2F&psig=AOvVaw2UkRVRKSLlDTw9lwPhP1Fm&ust=1682853279782000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCIDX-pf7zv4CFQAAAAAdAAAAABAE',
        placeholder: (context, url) => Container(
          color: Colors.amber,
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
