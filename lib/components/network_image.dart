import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:medizii/constants/strings.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholderImage;
  final String? errorImage;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholderImage = 'assets/placeholder.png',
    this.errorImage = 'assets/error.png',
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit!,
      placeholder: (context, url) => Container(
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
          ),
          child: const Center(child: CupertinoActivityIndicator())),
      errorWidget: (context, url, error) => Image.asset(ImageString.imgProfile),
    );
  }
}