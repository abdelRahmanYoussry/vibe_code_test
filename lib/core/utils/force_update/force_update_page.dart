import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../localization/gen/loc.dart';
import '../../widgets/pic.dart';

import 'force_update.dart';

class ForceUpdatePage extends StatelessWidget {
  const ForceUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Align(
        alignment: const Alignment(0, -.6),
        child: Column(
          children: [
            Pic(
              Assets.images.errorImage.path,
            ),
            SizedBox(height: 10.h),
            Text(
              Loc.of(context).force_update,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: ElevatedButton(
                onPressed: () {
                  ForceUpdate.openStore();
                },
                child: Text(Loc.of(context).update),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
