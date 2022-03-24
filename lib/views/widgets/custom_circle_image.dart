import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    return CachedNetworkImage(
      imageUrl: imagePath!,
      imageBuilder: (context, imageProvider) => Container(
        width: width!,
        height: height!,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).primaryColor, width: 5),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(opacity!), BlendMode.darken),
              image: imageProvider,
              fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) =>  _buildPlaceHolder(context),
      errorWidget: (context, url, error) => _buildErrorWidget(context),
    );
  }

  Widget _buildPlaceHolder(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width!,
          height: height!,
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).primaryColor, width: 5),
          ),
        ),
         Icon(
          Icons.image,
          size: 80,
          color: Colors.white.withOpacity(0.3),
        ),
        SpinKitCircle(color: Theme.of(context).primaryColor,),
      ],
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width!,
          height: height!,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).primaryColor, width: 5),
            image: DecorationImage(
                image:
                    const ExactAssetImage('assets/images/quran_background.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(opacity!), BlendMode.darken),
                fit: BoxFit.cover),
          ),
        ),
        const Icon(Icons.error),
      ],
    );
  }
}
