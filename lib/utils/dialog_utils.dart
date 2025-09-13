import 'package:flutter/material.dart';
import '../widgets/edit_user_dialog.dart';

class DialogUtils {
  static Future<Map<String, String>?> showEditUserDialog({
    required BuildContext context,
    required String initialName,
    required String initialEmail,
    required String initialPassword,
  }) async {
    return showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return EditUserDialog(
          initialName: initialName,
          initialEmail: initialEmail,
          initialPassword: initialPassword,
        );
      },
    );
  }

  // Versión con animación personalizada
  static Future<Map<String, String>?> showEditUserDialogWithAnimation({
    required BuildContext context,
    required String initialName,
    required String initialEmail,
    required String initialPassword,
  }) async {
    return showGeneralDialog<Map<String, String>>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return EditUserDialog(
          initialName: initialName,
          initialEmail: initialEmail,
          initialPassword: initialPassword,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
