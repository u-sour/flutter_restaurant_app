import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../utils/sale/sale_utils.dart';

class InvoiceTemplateCachedImgWidget extends StatelessWidget {
  final String ipAddress;
  final String imgUrl;
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;

  const InvoiceTemplateCachedImgWidget({
    super.key,
    required this.ipAddress,
    required this.imgUrl,
    required this.width,
    required this.height,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CachedNetworkImage(
        imageUrl: getImgSrc(ipAddress: ipAddress, imgUrl: imgUrl),
        height: width,
        width: height,
        errorWidget: (context, url, error) {
          return Text('$error');
        },
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageProvider,
              ),
            ),
          );
        },
      ),
    );
  }
}
