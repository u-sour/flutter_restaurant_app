import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InvoiceTemplateCachedImgWidget extends StatelessWidget {
  final bool isQrcode;
  final String ipAddress;
  final String imgUrl;
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;

  const InvoiceTemplateCachedImgWidget({
    super.key,
    this.isQrcode = true,
    required this.ipAddress,
    required this.imgUrl,
    required this.width,
    required this.height,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      maxHeightDiskCache: height.toInt(),
      errorWidget: (context, url, error) {
        return Text('$error');
      },
      imageBuilder: (context, imageProvider) {
        return Container(
          margin: margin,
          height: isQrcode ? height * 2 : height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: imageProvider,
            ),
          ),
        );
      },
    );
  }
}
