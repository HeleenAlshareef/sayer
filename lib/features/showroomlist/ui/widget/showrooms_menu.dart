import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/common/widgets/app_notification.dart'; // إشعار مخصص
import 'showroom_edit_dialog.dart';
import 'showroom_popup_items.dart';

class ShowroomMenu extends StatelessWidget {
  final String showroomId;

  const ShowroomMenu({Key? key, required this.showroomId}) : super(key: key);

  Future<void> deleteShowroom(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('ShowroomsOP')
          .doc(showroomId)
          .delete();

      context.showNotification(
        message: "تم حذف المعرض بنجاح",
        icon: Icons.check_circle_outline,
        iconColor: Colors.green,
      );
    } catch (e) {
      context.showNotification(
        message: "حدث خطأ أثناء الحذف ",
        icon: Icons.error_outlined,
        iconColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final popupShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: AppColors.black),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 10,
      shape: popupShape,
      shadowColor: Colors.black26,
      offset: const Offset(0, 8),
      constraints: const BoxConstraints(minWidth: 160),
      onSelected: (value) async {
        if (value == ShowroomMenuAction.delete) {
          await deleteShowroom(context);
        } else if (value == ShowroomMenuAction.edit) {
          await showShowroomEditDialog(context, showroomId: showroomId);
        }
      },
      itemBuilder: (context) => showroomPopupItems(context),
    );
  }
}
