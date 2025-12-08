import 'dart:async';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:flutter/material.dart';

import 'resend_otp_section_theme.dart';

class ResendOtpSection extends StatefulWidget {
  const ResendOtpSection({
    super.key,
    this.onResendOtp,
  });

  final VoidCallback? onResendOtp;

  @override
  State<ResendOtpSection> createState() => _ResendOtpSectionState();
}

class _ResendOtpSectionState extends State<ResendOtpSection> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _remainingSeconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Loc.of(context).didnt_receive_otp,
          style: ResendOtpSectionTheme.of(context).textStyle,
        ),
        TextButton(
          onPressed: _remainingSeconds == 0
              ? () {
            widget.onResendOtp?.call();
            _startTimer(); // Restart the timer after resending OTP
          }
              : null, // Disable button while timer is active
          child: Text(
            _remainingSeconds == 0
                ? Loc.of(context).resend_code
                : '${Loc.of(context).resend_code} ($_remainingSeconds)',
          ),
        ),
      ],
    );
  }
}
