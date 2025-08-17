import 'package:flutter/material.dart';
import 'package:sayer/features/showroomlist/ui/widget/details.dart';

class ShowroomGrid extends StatelessWidget {
  const ShowroomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: showroomList.length,
      itemBuilder: (context, index) {
        final showroom = showroomList[index];
        return GestureDetector(
          onTap:
              () => showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: Text(showroom.name),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(showroom.logoPath, height: 60),
                          const SizedBox(height: 10),
                          Text(showroom.description),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('إغلاق'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
              ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(showroom.logoPath),
            ),
          ),
        );
      },
    );
  }
}
