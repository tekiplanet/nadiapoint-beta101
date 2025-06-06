import 'package:flutter/material.dart';
import '../config/theme/colors.dart';
import 'package:provider/provider.dart';
import '../config/theme/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onThemeToggle;
  final String? title;
  final Widget? trailing;
  final bool hasNotification;

  const CustomAppBar({
    super.key,
    this.onNotificationTap,
    this.onThemeToggle,
    this.title,
    this.trailing,
    this.hasNotification = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark 
            ? SafeJetColors.primaryBackground
            : SafeJetColors.lightBackground,
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              // Logo
              SizedBox(
                height: 40,
                width: 120,
                child: Image.asset(
                  isDark ? 'assets/images/logo/logo-2c.png' : 'assets/images/logo/logo-2b.png',
                  fit: BoxFit.contain,
                  ),
              ),
              const Spacer(),
              
              // Action buttons in a Row with minimum size
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (trailing != null) trailing!,
                  if (trailing != null) const SizedBox(width: 8),
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: Stack(
                      children: [
                        const Icon(Icons.notifications_outlined),
                        if (hasNotification)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: SafeJetColors.secondaryHighlight,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onThemeToggle,
                    icon: Icon(
                      isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 