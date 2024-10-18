import 'package:flutter/material.dart';

class Consts {
  Consts._();
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class SuccessDialog extends StatelessWidget {
  final String? description;
  final VoidCallback? okClick;
  const SuccessDialog({Key? key, this.description, this.okClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: Consts.padding,
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      margin: const EdgeInsets.only(top: Consts.avatarRadius),
      decoration: BoxDecoration(
        color: const Color(0xFF1A3A3A), // Dark green background for dialog
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle, // Ikon sukses
            color: Colors.greenAccent, // Lighter green for the icon
            size: 60.0,
          ),
          const SizedBox(height: 16.0),
          const Text(
            "SUKSES",
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: Colors.greenAccent), // Lighter green for the title
          ),
          const SizedBox(height: 16.0),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors
                  .white, // Change text color to white for better contrast
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(); // To close the dialog
                if (okClick != null) okClick!();
              },
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    Colors.greenAccent, // Use a lighter green for the button
                foregroundColor: Colors.white, // Color for button text
              ),
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
  }
}
