import 'package:flutter/material.dart';
import 'package:gemma/models/crypto_state.dart';

class MarketMapWidget extends StatelessWidget {
  final List<Crypto> data;
  final double padding;

  const MarketMapWidget({
    Key? key,
    required this.data,
    this.padding = 4.0,
  }) : super(key: key);

  double _parseMarketCap(String? marketCap) {
    if (marketCap == null) return 0.0;
    try {
      // حذف کاراکترهای غیر عددی (مثل کاما)
      final cleanString = marketCap.replaceAll(RegExp(r'[^0-9.]'), '');
      return double.tryParse(cleanString) ?? 0.0;
    } catch (e) {
      print('Error parsing market cap: $marketCap');
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // مرتب‌سازی با استفاده از مقادیر عددی
    final sortedData = List<Crypto>.from(data)
      ..sort((a, b) {
        final aMarketCap = _parseMarketCap(a.marketCap);
        final bMarketCap = _parseMarketCap(b.marketCap);
        return bMarketCap.compareTo(aMarketCap);
      });

    return LayoutBuilder(
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
                  padding: EdgeInsets.all(padding),
                  child: _buildBox(sortedData[i], boxes[i].height),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBox(Crypto data, double boxHeight) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(data.dayChange!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        // محاسبه سایز فونت بر اساس ارتفاع باکس
        double fontSize = (constraints.maxHeight * 0.2).clamp(8.0, 14.0);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // اضافه کردن این خط
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                data.symbol!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '\$${data.latestPrice!}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 0.8,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${data.dayChange! >= 0 ? '+' : ''}${data.dayChange!.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 0.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  double _calculateTotalMarketCap(List<Crypto> data) {
    return data.fold(0.0, (sum, item) => sum + _parseMarketCap(item.marketCap));
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

    final totalMarketCap = _calculateTotalMarketCap(data);

    for (int i = 0; i < data.length; i++) {
      // استفاده از مقدار عددی برای محاسبه نسبت
      final marketCap = _parseMarketCap(data[i].marketCap);
      final ratio = totalMarketCap > 0 ? marketCap / totalMarketCap : 0.0;
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
    if (change > 0) {
      return Color.lerp(
        Colors.green,
        Colors.white,
        0.8 - (change.clamp(0, 20) / 25),
      )!;
    } else {
      return Color.lerp(
        Colors.red,
        Colors.white,
        0.8 - (change.abs().clamp(0, 20) / 25),
      )!;
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
