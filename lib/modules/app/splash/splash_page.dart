import 'dart:async';

import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/assets/gen/assets.gen.dart';
import '../../../core/di/di.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // requestPermissions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => di<SplashBloc>()
        ..checkUser(),
      lazy: false,
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashBloc, SplashState>(
            listenWhen: (previous, current) => previous.hasUser != current.hasUser,
            listener: (context, state) {
              if (state.hasUser == true) {
                // handle after Auth with token to check if got to home or login

               Nav.root.replaceAll(context);

                return;
              }
              if (state.isOnBoardingSkipped == true) {
                //check if skip button is clicked go to login

                Timer(const Duration(seconds: 1), () {
                 Nav.login.replaceAll(context);
                });
              } else {
                Timer(const Duration(seconds: 1), () {
                  // Nav.selectLang(context);
                  Nav.onBoarding.replaceAll(context);
                });
              }

              // Nav.onBoard(context);
            },
          ),
        ],
        child: CustomScaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                alignment: AlignmentDirectional.center,
                child: Pic(
                 Assets.images.splashImage.path,
                  fit: BoxFit.cover,
                  height: 120.h,
                  // width: 150.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
