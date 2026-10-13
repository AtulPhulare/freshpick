import 'package:flutter/material.dart';

import '../../../../core/common/common_button.dart';
import '../../../../core/constants/app_colors.dart';

/// Shows the logout confirmation sheet.
/// Resolves to `true` when the user confirms, `false`/`null` otherwise.
Future<bool?> showLogoutBottomSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const LogoutBottomSheet(),
  );
}

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: 34,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Log Out',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Are you sure you want to log out of your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context, false),
                    backgroundColor: AppColors.textGrey,
                    outlined: true,
                    borderWidth: 1.5,
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CommonButton(
                    text: 'Log Out',
                    onPressed: () => Navigator.pop(context, true),
                    backgroundColor: AppColors.error,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
