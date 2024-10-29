import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemma/assets/colors.dart';
import 'package:gemma/models/crypto_state.dart';
import 'package:gemma/providers/crypto_data_provider.dart';

class MarketMapWidget extends StatefulWidget {
  final List<Crypto> data;
  final CurrencyType currencyType; // نگه داشتن پارامتر ورودی
  final double padding;

  MarketMapWidget({
    Key? key,
    required this.data,
    required this.currencyType, // همچنان required نگه داشته شده
    this.padding = 2.0,
  }) : super(key: key);

  @override
  State<MarketMapWidget> createState() => _MarketMapWidgetState();
}

class _MarketMapWidgetState extends State<MarketMapWidget> {
  late CurrencyType _currencyType; // متغیر برای نگهداری state داخلی

  @override
  void initState() {
    super.initState();
    _currencyType = widget.currencyType; // مقداردهی اولیه از widget
  }

  void _toggleCurrencyType() {
    setState(() {
      _currencyType = _currencyType == CurrencyType.tether
          ? CurrencyType.irt
          : CurrencyType.tether;
    });
  }

  double _parseVolume(String volume) {
    // منطق پارس کردن حجم معاملات رو اینجا پیاده‌سازی کنید
    // مثلا: حذف کاراکترهای غیر عددی و تبدیل به double
    return double.tryParse(volume.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  }


  @override
  Widget build(BuildContext context) {
    final sortedData = List<Crypto>.from(widget.data)
      ..sort((a, b) {
        final aMarketCap = _parseVolume(a.volumeSrc!);
        final bMarketCap = _parseVolume(b.volumeSrc!);
        return bMarketCap.compareTo(aMarketCap);
      });

    return Scaffold(
      backgroundColor: blue100Safaii,
      appBar: AppBar(
        backgroundColor: blue100Safaii,
          elevation: 0,
          title: Text(
            _currencyType == CurrencyType.tether
                ? 'نقشه بازار تتری'
                : 'نقشه بازار تومانی',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Transform.scale(
                scaleX: -1,
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            )
          ],
          leading: IconButton(
            onPressed: _toggleCurrencyType,
            icon: _currencyType == CurrencyType.tether
                ? SvgPicture.asset(
              'images/usdt.svg',
              width: 25,
              height: 25,
            )
                : SvgPicture.asset(
              'images/iran.svg',
              width: 25,
              height: 25,
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final boxes = _calculateBoxSizes(
              sortedData,
              constraints.maxWidth,
              constraints.maxHeight,
            );

            return Stack(
              children: [
                for (int i = 0; i < boxes.length; i++)
                  Positioned(
                    left: boxes[i].left,
                    top: boxes[i].top,
                    width: boxes[i].width,
                    height: boxes[i].height,
                    child: Padding(
                      padding: EdgeInsets.all(widget.padding),
                      child: _buildBox(
                          sortedData[i], boxes[i].height, _currencyType),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBox(Crypto data, double boxHeight, CurrencyType currencyType) {
    String pricePrefix = currencyType == CurrencyType.tether ? '\$' : '';
    String priceSuffix = currencyType == CurrencyType.irt ? ' تومان' : '';
    final safeDayChange = data.dayChange ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(safeDayChange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final TextStyle style = TextStyle(fontSize: 16);
          String displayText = '';

          // تعیین متن نمایشی بر اساس عرض در دسترس
          if (constraints.maxWidth > 200) {
            displayText = '${data.symbol!}\n$pricePrefix${data.latestPrice}$priceSuffix\n${safeDayChange}';
          } else if (constraints.maxWidth > 150) {
            displayText = '${data.symbol!}\n$pricePrefix${data.latestPrice}$priceSuffix';
          } else {
            // برای فضاهای خیلی کوچک، حداقل یک حرف نمایش داده می‌شود
            displayText = _getMinimalText(data.symbol!);
          }

          return Center(
            child: Container(
              width: constraints.maxWidth,
              child: Text(
                _truncateText(displayText, constraints.maxWidth - 16, style, context),
                style: style,
                textAlign: TextAlign.center, // تنظیم متن به صورت وسط‌چین
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }

// تابع جدید برای گرفتن حداقل متن قابل نمایش
  String _getMinimalText(String symbol) {
    if (symbol.isEmpty) return '';
    // اگر متن تک کاراکتری باشد، همان را برمی‌گرداند
    if (symbol.length <= 1) return symbol;
    // در غیر این صورت، اولین حرف را برمی‌گرداند
    return symbol[0];
  }

  String _truncateText(String text, double maxWidth, TextStyle style, BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.rtl, // تغییر جهت متن برای پشتیبانی از فارسی
      textAlign: TextAlign.center, // تنظیم text painter به صورت وسط‌چین
    );

    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    if (textPainter.width <= maxWidth) {
      return text;
    }

    int low = 0;
    int high = text.length;
    String result = '';

    while (low <= high) {
      int mid = (low + high) ~/ 2;
      String truncated = text.substring(0, mid) + '...';
      textPainter.text = TextSpan(text: truncated, style: style);
      textPainter.layout(minWidth: 0, maxWidth: double.infinity);

      if (textPainter.width <= maxWidth) {
        result = truncated;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    return result;
  }

  double _calculateTotalVolume(List<Crypto> data) {
    return data.fold(0.0, (sum, crypto) => sum + _parseVolume(crypto.volumeSrc!));
  }

  List<BoxPosition> _calculateBoxSizes(
      List<Crypto> data,
      double containerWidth,
      double containerHeight,
      ) {
    final List<BoxPosition> positions = [];
    double currentX = 0;
    double currentY = 0;
    double remainingWidth = containerWidth;
    double remainingHeight = containerHeight;

    // تغییر به محاسبه کل حجم معاملات
    final totalVolume = _calculateTotalVolume(data);

    for (int i = 0; i < data.length; i++) {
      // استفاده از حجم معاملات به جای مارکت کپ
      final volume = _parseVolume(data[i].volumeSrc!);
      final ratio = totalVolume > 0 ? volume / totalVolume : 0.0;
      final area = containerWidth * containerHeight * ratio;

      double width, height;
      if (remainingWidth > remainingHeight) {
        width = area / remainingHeight;
        height = remainingHeight;
      } else {
        height = area / remainingWidth;
        width = remainingWidth;
      }

      positions.add(BoxPosition(
        left: currentX,
        top: currentY,
        width: width,
        height: height,
      ));

      if (remainingWidth > remainingHeight) {
        currentX += width;
        remainingWidth -= width;
      } else {
        currentY += height;
        remainingHeight -= height;
      }
    }

    return positions;
  }

  Color _getBackgroundColor(double change) {
    if (change == 0) {
      return greyMarket;
    }

    // برای تغییرات مثبت
    if (change > 0) {
      if (change >= 5) {
        return green100Market; // تغییرات شدید مثبت
      } else if (change >= 2) {
        return green50Market; // تغییرات متوسط مثبت
      } else {
        return green20Market; // تغییرات کم مثبت
      }
    }

    // برای تغییرات منفی
    else {
      if (change <= -5) {
        return red100Market; // تغییرات شدید منفی
      } else if (change <= -2) {
        return red50Market; // تغییرات متوسط منفی
      } else {
        return red20Market; // تغییرات کم منفی
      }
    }
  }
}

class BoxPosition {
  final double left;
  final double top;
  final double width;
  final double height;

  BoxPosition({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });
}



