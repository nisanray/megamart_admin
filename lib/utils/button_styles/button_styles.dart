import 'package:flutter/material.dart';

class ButtonColors {
  static const Color primaryColor = Color(0xFF6200EA);
  static const Color primaryColorLight = Color(0xFFBB86FC);
  static const Color primaryColorDark = Color(0xFF3700B3);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color secondaryColorLight = Color(0xFF66FFF9);
  static const Color secondaryColorDark = Color(0xFF00A896);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color successColorLight = Color(0xFF81C784);
  static const Color successColorDark = Color(0xFF388E3C);
  static const Color dangerColor = Color(0xFFF44336);
  static const Color dangerColorLight = Color(0xFFE57373);
  static const Color dangerColorDark = Color(0xFFD32F2F);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color warningColorLight = Color(0xFFFFE082);
  static const Color warningColorDark = Color(0xFFFFA000);
  static const Color infoColor = Color(0xFF2196F3);
  static const Color infoColorLight = Color(0xFF64B5F6);
  static const Color infoColorDark = Color(0xFF1976D2);
  static const Color lightColor = Color(0xFFFFFFFF);
  static const Color darkColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color greyColorLight = Color(0xFFBDBDBD);
  static const Color greyColorDark = Color(0xFF616161);
  static const Color purpleColor = Color(0xFF9C27B0);
  static const Color purpleColorLight = Color(0xFFBA68C8);
  static const Color purpleColorDark = Color(0xFF7B1FA2);
  static const Color orangeColor = Color(0xFFFF9800);
  static const Color orangeColorLight = Color(0xFFFFB74D);
  static const Color orangeColorDark = Color(0xFFF57C00);
  static const Color tealColor = Color(0xFF009688);
  static const Color tealColorLight = Color(0xFF4DB6AC);
  static const Color tealColorDark = Color(0xFF00796B);
  static const Color pinkColor = Color(0xFFE91E63);
  static const Color pinkColorLight = Color(0xFFF06292);
  static const Color pinkColorDark = Color(0xFFC2185B);

  // Text styles
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // Define button style colors here
  static final ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor),
    foregroundColor: MaterialStateProperty.all(lightColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(primaryColorDark),
  );

  static final ButtonStyle secondaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(secondaryColor),
    foregroundColor: MaterialStateProperty.all(darkColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(secondaryColorDark),
  );

  static final ButtonStyle successButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(successColor),
    foregroundColor: MaterialStateProperty.all(lightColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(successColor.withOpacity(0.5)),
  );

  static final ButtonStyle dangerButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(dangerColor),
    foregroundColor: MaterialStateProperty.all(lightColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(dangerColor.withOpacity(0.5)),
  );

  static final ButtonStyle warningButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(warningColor),
    foregroundColor: MaterialStateProperty.all(darkColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(warningColor.withOpacity(0.5)),
  );

  static final ButtonStyle infoButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(infoColor),
    foregroundColor: MaterialStateProperty.all(lightColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(infoColor.withOpacity(0.5)),
  );

  static final ButtonStyle lightButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(lightColor),
    foregroundColor: MaterialStateProperty.all(darkColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
  );

  static final ButtonStyle darkButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(darkColor),
    foregroundColor: MaterialStateProperty.all(lightColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
  );



  static final ButtonStyle greyButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(greyColor),
    foregroundColor: MaterialStateProperty.all(darkColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(greyColorDark.withOpacity(0.5)),
  );

  static final ButtonStyle purpleButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(purpleColor),
    foregroundColor: MaterialStateProperty.all(lightColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(purpleColorDark.withOpacity(0.5)),
  );

  static final ButtonStyle orangeButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(orangeColor),
    foregroundColor: MaterialStateProperty.all(lightColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(8),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    shadowColor: MaterialStateProperty.all(orangeColorDark.withOpacity(0.5)),
  );
}
