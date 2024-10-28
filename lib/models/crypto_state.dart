class Crypto {
  String? name;
  String? latestPrice; // Changed from String to double
  double? dayChange;
  String? marketCap;
  String? bestSell;
  String? bestBuy;
  String? dayLow;
  String? dayHigh;
  String? dayOpen;
  String? dayClose;
  String? volumeSrc;
  String? volumeDst;
  bool? isClosed;
  String? iconUrl;
  String? symbol;
  String? error;
  String? color;

  Crypto(
      this.name,
      this.latestPrice,
      this.dayChange,
      this.marketCap,
      this.bestSell,
      this.bestBuy,
      this.dayLow,
      this.dayHigh,
      this.dayOpen,
      this.dayClose,
      this.volumeSrc,
      this.volumeDst,
      this.isClosed,
      this.iconUrl,
      this.symbol,
      this.color);

  factory Crypto.error(String errorMessage) {
    return Crypto(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    )..error = errorMessage;
  }

  factory Crypto.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return Crypto(
      jsonMapObject['name'],
      jsonMapObject['latest'],
      double.tryParse(jsonMapObject['dayChange']?.toString() ?? '0'),
      jsonMapObject['marketCap'],
      jsonMapObject['bestSell'],
      jsonMapObject['bestBuy'],
      jsonMapObject['dayLow'],
      jsonMapObject['dayHigh'],
      jsonMapObject['dayOpen'],
      jsonMapObject['dayClose'],
      jsonMapObject['volumeSrc'],
      jsonMapObject['volumeDst'],
      jsonMapObject['isClosed'] != null
          ? bool.tryParse(jsonMapObject['isClosed'].toString()) ?? false
          : false,
      jsonMapObject['iconUrl'],
      jsonMapObject['symbol'],
      jsonMapObject['color'],
    );
  }
}