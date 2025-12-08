// import 'package:flutter/material.dart';
//
// class SearchFieldTheme extends ThemeExtension<SearchFieldTheme> {
//   static SearchFieldTheme of(BuildContext context) => Theme.of(context).extension<SearchFieldTheme>()!;
//
//   final InputDecorationTheme inputDecorationTheme;
//
//   const SearchFieldTheme({
//     required this.inputDecorationTheme,
//   });
//
//   @override
//   ThemeExtension<SearchFieldTheme> copyWith({
//     InputDecorationTheme? inputDecorationTheme,
//   }) =>
//       SearchFieldTheme(
//         inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
//       );
//
//   @override
//   ThemeExtension<SearchFieldTheme> lerp(covariant ThemeExtension<SearchFieldTheme>? other, double t) {
//     if (other is! SearchFieldTheme) {
//       return this;
//     }
//     return SearchFieldTheme(
//       inputDecorationTheme: other.inputDecorationTheme,
//     );
//   }
// }
