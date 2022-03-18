import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CustomCourseItem extends StatelessWidget {
  final String? name, imageUrl;
  final int videosCount;
  final Function()? onTap;
  const CustomCourseItem(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.videosCount,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      elevation: 5,
      child: ListTile(
        onTap: onTap!,
        leading: CircleAvatar(
          backgroundImage: ExactAssetImage(imageUrl!),
        ),
        title: Text(
          name!,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
            fontFamily: 'cairo',
          ),
        ),
        subtitle: Text(
          '$videosCount درس',
          style: const TextStyle(
            letterSpacing: 1.5,
            fontFamily: 'cairo',
          ),
        ),
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}
