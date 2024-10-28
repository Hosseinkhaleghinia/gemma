import 'package:flutter/material.dart';
import 'colors.dart';

/**
 *!Widget field
 **  این ویجت یک فیدل را به صورت کامل و آماده در اختیار میگذارد تا در صورت نیاز به فیلدهایی که قرار است کاربر آنها را پر کند استفاده شود
 */

Widget field(
  String name,
  Color hiveColor,
  Icon iconFeild,
) {
  return Container(
    decoration: BoxDecoration(
        color: backgrand, borderRadius: BorderRadius.all(Radius.circular(15))),
    width: 280,
    height: 50,
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        textDirection: TextDirection.rtl,
        // برای راست‌چین کردن متن داخل TextField
        decoration: InputDecoration(
          labelText: name,
          labelStyle: TextStyle(
            color: blue100Safaii, // رنگ دلخواه برای labelText
          ),
          hintTextDirection: TextDirection.rtl,
          suffixIcon: iconFeild,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: blue100Safaii),
            // رنگ و ضخامت برای حالت غیرفعال
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: hiveColor),
            // رنگ و ضخامت برای حالت فعال (زمانی که TextField در فوکوس است)
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
  );
} //!Widget field

/**
 * ! Widget saffaiiName
 ** این تابع مربوط به استایل اسم صفایی هست که هر حرف آن استایل دلخواه خود را خواهند داشت
 */
Widget saffaiiName() {
  return RichText(
    text: TextSpan(
      text: '',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      children: <TextSpan>[
        TextSpan(
          text: 'S',
          style: TextStyle(color: redSafaii),
        ),
        TextSpan(
          text: 'A',
          style: TextStyle(color: grey40Safaii),
        ),
        TextSpan(
          text: 'F',
          style: TextStyle(color: yellow70Safaii),
        ),
        TextSpan(
          text: 'A',
          style: TextStyle(color: grey40Safaii),
        ),
        TextSpan(
          text: 'I',
          style: TextStyle(color: blue20Safaii),
        ),
        TextSpan(
          text: 'I',
          style: TextStyle(color: blue20Safaii),
        ),
      ],
    ),
  );
} //! Widget saffaiiName
