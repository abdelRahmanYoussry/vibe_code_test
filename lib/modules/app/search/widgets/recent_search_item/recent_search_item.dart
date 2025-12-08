import 'package:flutter/material.dart';

import '../../model/search_recent_model.dart';
import 'recent_search_item_theme.dart';

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({
    super.key,
    required this.model,
    this.onClearPressed,
    this.onTapPressed,
  });

  final SearchedProductModel model;
  final VoidCallback? onClearPressed;
  final VoidCallback? onTapPressed;

  @override
  Widget build(BuildContext context) {
    final myTheme = RecentSearchItemTheme.of(context);
    return GestureDetector(
      onTap: () {
        onTapPressed?.call();
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              model.name,
              style: myTheme.labelStyle,
            ),
          ),
          IconButton(
            onPressed: () {
              onClearPressed?.call();
            },
            icon: Icon(
              Icons.close,
              color: myTheme.iconThemeData.color,
              size: myTheme.iconThemeData.size,
            ),
          ),
        ],
      ),
    );
  }
}
