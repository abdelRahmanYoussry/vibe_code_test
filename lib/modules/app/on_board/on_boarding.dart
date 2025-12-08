import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../core/assets/gen/assets.gen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  // int _currentPage = 0;
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  List<_OnboardPage> _buildPages(BuildContext context) {
    return [
      _OnboardPage(
        imagePath: Assets.images.onBoarding1.path,
        title: "${Loc.of(context).the_best_experience}\n${Loc.of(context).enjoying_coffee}",
        subtitle: Loc.of(context).on_boarding_subtitle1,
      ),
      _OnboardPage(
        imagePath: Assets.images.onBoarding2.path,
        title: "${Loc.of(context).share_the_Perks_with_the}\n${Loc.of(context).claro_coffee_app}",
        subtitle: Loc.of(context).on_boarding_subtitle2,
      ),
      _OnboardPage(
        imagePath: Assets.images.onBoarding3.path,
        title: "${Loc.of(context).enjoy_benefits_through_the}\n${Loc.of(context).claro_coffee_app}",
        subtitle: Loc.of(context).on_boarding_subtitle3,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  void _onSignInPressed() {
    Nav.login.replaceAll(context);
  }

  void _onSkipPressed() {
    Nav.login.replaceAll(context);
  }

  @override
  dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color brown = Color(0xFF4C3422); // Example brown color

    return CustomScaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, value, child) => Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _buildPages(context).length,
                  onPageChanged: (index) => _currentPage.value = index,
                  itemBuilder: (context, index) {
                    final page = _buildPages(context)[_currentPage.value];
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Add this line
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Pic(
                                page.imagePath,
                                height: 260.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              page.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: brown,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              page.subtitle,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: brown,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _buildPageIndicator(),
                          ],
                        ),);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        onPressed: _onSignInPressed,
                        child: Text(
                          Loc.of(context).sign_in,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _onSkipPressed,
                      child: Text(
                        Loc.of(context).skip,
                        style: TextStyle(
                          fontSize: 16,
                          color: brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_buildPages(context).length, (index) {
        bool isActive = index == _currentPage.value;
        return AnimatedContainer(
          duration: Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF4C3422) : Color(0xFFD4D0CC),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _OnboardPage {
  final String imagePath;
  final String title;
  final String subtitle;

  _OnboardPage({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}
