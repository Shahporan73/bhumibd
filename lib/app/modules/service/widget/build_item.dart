import 'package:bhumibd/app/resource/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData? icon;
  const BuildItem({super.key, required this.title, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 1,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon ?? Icons.push_pin,
              size: 18,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            CustomText(
              title: title,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
