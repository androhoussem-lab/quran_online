import 'package:flutter/material.dart';

void showConfirmationDialog(
    {required BuildContext context,
    required String title,
    required String body,
    required String confirmButtonText,
    required String cancelButtonText,
    required Function()? confirm,
    required Function()? cancel}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            title,
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
          content: Text(
            body,
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: cancel,
              child: Text(
                cancelButtonText,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.grey.shade500,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: confirm,
              child: Text(
                confirmButtonText,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      });
}
