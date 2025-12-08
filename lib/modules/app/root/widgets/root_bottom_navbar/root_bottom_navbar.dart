import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/core/widgets/order_selector/order_selector.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/modules/app/root/widgets/root_bottom_navbar/root_bottom_navbar_theme.dart';
import 'package:flutter/material.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final myTheme = RootBottomNavbarTheme.of(context);
    final items = [
      (icon: Assets.icons.home.path, label: Loc.of(context).home),
      (icon: Assets.icons.notes.path, label: Loc.of(context).orders),
      (icon: Assets.icons.person.path, label: Loc.of(context).profile),
    ];

    return DividerTheme(
      data: myTheme.dividerTheme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            items: List.generate(items.length, (index) {
              final item = items[index];

              // For orders tab (index 1)
              if (index == 1) {
                return BottomNavigationBarItem(
                  label: item.label,
                  icon: OrdersSelector(
                    builder: (context, orderCount) {
                      final iconTheme = IconTheme.of(context);
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Pic(
                            item.icon,
                            width: iconTheme.size,
                            height: iconTheme.size,
                            color: iconTheme.color,
                          ),
                          if (orderCount > 0)
                            Positioned(
                              right: -20,
                              top: -5,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: AppColors.brown33,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '$orderCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                );
              }

              // For other tabs
              return BottomNavigationBarItem(
                label: item.label,
                icon: Builder(
                  builder: (context) {
                    final iconTheme = IconTheme.of(context);
                    return Pic(
                      item.icon,
                      width: iconTheme.size,
                      height: iconTheme.size,
                      color: iconTheme.color,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
