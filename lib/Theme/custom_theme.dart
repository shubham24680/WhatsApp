import 'package:flutter/material.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static final lightMode = CustomThemeExtension(
    background: Colors.teal[600],
    doodleColor: Colors.greenAccent[400],
    titleColor: Colors.black,
    subTitleColor: Colors.black,
  );
  static final darkMode = CustomThemeExtension(
    background: Colors.teal[700],
    doodleColor: Colors.teal[400],
    titleColor: Colors.white,
    subTitleColor: Colors.grey[600],
  );
  late final Color? background;
  late final Color? doodleColor;
  late final Color? titleColor;
  late final Color? subTitleColor;

  CustomThemeExtension({
    this.background,
    this.doodleColor,
    this.titleColor,
    this.subTitleColor,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? background,
    Color? doodleColor,
    Color? titleColor,
    Color? subTitleColor,
  }) {
    return CustomThemeExtension(
      background: background ?? this.background,
      doodleColor: doodleColor ?? this.doodleColor,
      titleColor: titleColor ?? this.titleColor,
      subTitleColor: subTitleColor ?? this.subTitleColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      covariant ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      background: Color.lerp(background, other.background, t),
      doodleColor: Color.lerp(doodleColor, other.doodleColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      subTitleColor: Color.lerp(subTitleColor, other.subTitleColor, t),
    );
  }
}
