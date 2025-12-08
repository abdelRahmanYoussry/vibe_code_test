import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../di/di.dart';
import '../../navigation/nav_obs.dart';


class SnackBarBuilder {
  static showFeedBackMessage(BuildContext context, String message, {bool addBehaviour = true, bool isSuccess = true,int duration = 1,VoidCallback? onTap}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final theme = Theme.of(context);
    debugPrint('${message}message');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GestureDetector(
          behavior: HitTestBehavior.opaque ,
          onTap: onTap ?? () {},
          child: Text(
            textAlign: TextAlign.center,
            message,
            maxLines: isSuccess?3:5,
            style:isSuccess? theme.snackBarTheme.contentTextStyle: theme.snackBarTheme.contentTextStyle?.copyWith(color:Colors.black),
          ),
        ),
        margin: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 5.h,
          top: 5.h,
        ),
        backgroundColor: isSuccess ?theme.snackBarTheme.backgroundColor : Color(0xFFfba6a1),
        dismissDirection: DismissDirection.up,
        duration:  Duration(seconds: isSuccess? duration:duration+1),
        // padding: EdgeInsets.only(bottom: 5.h),
        behavior: addBehaviour ? SnackBarBehavior.floating : null,
      ),
    );
  }
}



// class AddToCartSnackBarBuilder {
//   static showFeedBackMessage(BuildContext context, String price, String totalCount ,{bool addBehaviour = true, bool isSuccess = true}) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     final theme = Theme.of(context);
//     debugPrint('${price}price');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: GestureDetector(
//           onTap: () {
//             Nav.cart.push(context);
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//           },
//           behavior: HitTestBehavior.opaque ,
//           child: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(5.w) ,
//                 decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.white, width: 2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   totalCount,
//                   style: theme.snackBarTheme.contentTextStyle,
//                 ),
//               ),
//               SizedBox(width: 10.w),
//               Text(
//                 textAlign: TextAlign.center,
//                 Loc.of(context).view_cart,
//                 style: theme.snackBarTheme.contentTextStyle,
//               ),
//               Spacer(),
//               Text(
//                 textAlign: TextAlign.center,
//                 price,
//                 style: theme.snackBarTheme.contentTextStyle,
//               ),
//
//             ],
//           ),
//         ),
//         margin: EdgeInsets.only(
//           left: 16.w,
//           right: 16.w,
//           bottom: 5.h,
//           top: 5.h,
//         ),
//         backgroundColor: isSuccess ?theme.snackBarTheme.backgroundColor : Colors.red,
//         dismissDirection: DismissDirection.up,
//         duration: const Duration(seconds: 7),
//         behavior: addBehaviour ? SnackBarBehavior.floating : null,
//       ),
//     );
//
//     // Add a callback for when the snackbar is closed
//     snackBarController.closed.then((_) {
//       subscription.cancel();
//     });
//   }
// }

class AddToCartSnackBarBuilder {
  static void showFeedBackMessage(BuildContext context, String price, String totalCount, {bool addBehaviour = true, bool isSuccess = true}) {
    // Get navigation observer from dependency injection
    final navObs = di<NavObs>();

    // Don't show snackbar if already on cart page
    if (navObs.current == Nav.cart) {
      debugPrint('Already on cart page, not showing snackbar');
      return;
    }

    // Clear existing snackbars first
    ScaffoldMessenger.of(context).clearSnackBars();
    final theme = Theme.of(context);

    // Get the ScaffoldMessengerState to control the snackbar
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Store the current navigation state
    final Nav? initialPage = navObs.current;
    debugPrint('initialPage $initialPage');
    debugPrint('navObs.current ${navObs.current}');

    // Create a listener for navigation changes
    void navListener() {
      if (navObs.current != initialPage) {
        // If page changed, hide the snackbar
        scaffoldMessenger.hideCurrentSnackBar();
      }
    }

    // Setup a listener that checks for navigation changes
    final subscription = Stream<void>.periodic(const Duration(milliseconds: 300)).listen((_) {
      navListener();
    });

    // Show the snackbar and get the controller
    final snackBarController = scaffoldMessenger.showSnackBar(
      SnackBar(
        content: GestureDetector(
          onTap: () {
            Nav.cart.push(context);
            scaffoldMessenger.hideCurrentSnackBar();
            subscription.cancel();
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white, width: 2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  totalCount,
                  style: theme.snackBarTheme.contentTextStyle,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                textAlign: TextAlign.center,
                Loc.of(context).view_cart,
                style: theme.snackBarTheme.contentTextStyle,
              ),
              Spacer(),
              Text(
                textAlign: TextAlign.center,
                price,
                style: theme.snackBarTheme.contentTextStyle,
              ),
            ],
          ),
        ),
        margin: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 5.h,
          top: 5.h,
        ),
        backgroundColor: isSuccess ? theme.snackBarTheme.backgroundColor : Colors.red,
        dismissDirection: DismissDirection.up,
        duration: const Duration(seconds: 7),
        behavior: addBehaviour ? SnackBarBehavior.floating : null,
      ),
    );

    // Add a callback for when the snackbar is closed
    snackBarController.closed.then((_) {
      subscription.cancel();
    });
  }
}
