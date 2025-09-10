import 'package:flutter/material.dart';

class ShowroomMenuAction {
  static const String edit = 'edit';
  static const String delete = 'delete';
}

List<PopupMenuEntry<String>> showroomPopupItems(BuildContext context) {
  return [
    const PopupMenuItem<String>(
      value: ShowroomMenuAction.edit,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        'تعديل المعرض',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
    PopupMenuItem<String>(
      value: ShowroomMenuAction.delete,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        'حذف المعرض',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.red.shade600,
        ),
      ),
    ),
  ];
}
