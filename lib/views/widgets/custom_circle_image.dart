import 'dart:ui';

import 'package:flutter/material.dart';

class CustomCircleImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imagePath;
  final Color? borderColor;
  final double? opacity;

  const CustomCircleImage(
      {Key? key,
      required this.width,
      required this.height,
      required this.imagePath,
      required this.borderColor,
      required this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width!,
      height: height!,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).primaryColor, width: 4),
      ),
      child: _buildImage(imagePath!),
    );
  }

  Widget _buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(180),
      child: ImageFiltered(
        imageFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        child: Image.network(
          imagePath,
          width: width!,
          height: height!,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, object, stacktrace) => _buildErrorWidget(context),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      width: width!,
      height: height!,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).primaryColor, width: 5),
        image:  DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(opacity!), BlendMode.darken),
          image: const ExactAssetImage('assets/images/quran_background.jpg'),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}
