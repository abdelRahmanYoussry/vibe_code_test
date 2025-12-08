import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/sheets/custom_sheet/custom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class SelectTimeSheet extends StatelessWidget {
  const SelectTimeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSheet(
      title: Text(Loc.of(context).select_time),
      icon: Icon(Icons.more_time),
      builder: (context) => Column(
        children: [
          CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 5,
            onTimerDurationChanged: (Duration value) {},
          ),
          SizedBox(height: 24.h),
          Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Loc.of(context).cancel),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    //todo return selected time
                    Navigator.of(context).pop();
                  },
                  child: Text(Loc.of(context).confirm),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
