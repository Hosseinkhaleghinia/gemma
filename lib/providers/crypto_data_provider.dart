import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gemma/models/crypto_state.dart';
import 'package:gemma/models/coinranking_api_server.dart';
import 'package:gemma/models/nobitex_api_server.dart';

enum SortOrder { none, ascending, descending }

enum CurrencyType { tether, irt }

class CryptoDataProvider with ChangeNotifier {
  final CoinrankingServer _cryptoCoinRanking = CoinrankingServer();
  final NobitexApiServer _cryptoNobitex = NobitexApiServer();

  // لیست‌های جداگانه برای ارزهای تتری و تومانی
  List<Crypto> _tetherData = [];
  List<Crypto> _irtData = [];
  List<Crypto> _filteredTetherData = [];
  List<Crypto> _filteredIrtData = [];

  bool _isLoading = true;
  CurrencyType _selectedCurrency = CurrencyType.irt;

  final numberFormat = NumberFormat('#,##0.###');

  // تعریف متغیرهای نگهدارنده وضعیت فیلترها برای هر نوع ارز
  Map<CurrencyType, SortOrder> _priceOrder = {
    CurrencyType.tether: SortOrder.none,
    CurrencyType.irt: SortOrder.none,
  };
  Map<CurrencyType, SortOrder> _changeOrder = {
    CurrencyType.tether: SortOrder.none,
    CurrencyType.irt: SortOrder.none,
  };
  Map<CurrencyType, SortOrder> _volumeOrder = {
    CurrencyType.tether: SortOrder.none,
    CurrencyType.irt: SortOrder.none,
  };
  Map<CurrencyType, SortOrder> _nameOrder = {
    CurrencyType.tether: SortOrder.none,
    CurrencyType.irt: SortOrder.none,
  };

  // گترها
  List<Crypto> getTetherList() =>
      _filteredTetherData.isEmpty ? _tetherData : _filteredTetherData;

  List<Crypto> getIRTList() =>
      _filteredIrtData.isEmpty ? _irtData : _filteredIrtData;

  bool get isLoading => _isLoading;

  void setSelectedCurrency(CurrencyType type) {
    _selectedCurrency = type;
    notifyListeners();
  }

  // متدهای کمکی برای فرمت‌دهی
  String formatPrice(String priceStr) {
    if (priceStr.endsWith('.0')) {
      priceStr = priceStr.substring(0, priceStr.length - 2);
    }
    return numberFormat.format(double.parse(priceStr));
  }

  String formatVolumeDst(String volume) {
    if (volume != null) {
      double? volumeSrt = double.tryParse(volume.toString());
      volume = numberFormat.format(volumeSrt);
    }
    return volume;
  }

  // متد مرتب‌سازی بر اساس قیمت
  void sortByPrice(SortOrder order) {
    _priceOrder[_selectedCurrency] = order;
    _changeOrder[_selectedCurrency] = SortOrder.none;
    _volumeOrder[_selectedCurrency] = SortOrder.none;
    _nameOrder[_selectedCurrency] = SortOrder.none;

    List<Crypto> dataToSort = _selectedCurrency == CurrencyType.tether
        ? List.from(_tetherData)
        : List.from(_irtData);

    if (order == SortOrder.none) {
      if (_selectedCurrency == CurrencyType.tether) {
        _filteredTetherData = dataToSort;
      } else {
        _filteredIrtData = dataToSort;
      }
    } else {
      dataToSort.sort((a, b) {
        double priceA =
            double.tryParse(a.latestPrice?.replaceAll(',', '') ?? '0') ?? 0;
        double priceB =
            double.tryParse(b.latestPrice?.replaceAll(',', '') ?? '0') ?? 0;
        return order == SortOrder.ascending
            ? priceA.compareTo(priceB)
            : priceB.compareTo(priceA);
      });

      if (_selectedCurrency == CurrencyType.tether) {
        _filteredTetherData = dataToSort;
      } else {
        _filteredIrtData = dataToSort;
      }
    }
    notifyListeners();
  }

  void sortByDayChange(SortOrder order) {
    _changeOrder[_selectedCurrency] = order;
    _priceOrder[_selectedCurrency] = SortOrder.none;
    _volumeOrder[_selectedCurrency] = SortOrder.none;
    _nameOrder[_selectedCurrency] = SortOrder.none;

    List<Crypto> dataToSort = _selectedCurrency == CurrencyType.tether
        ? List.from(_tetherData)
        : List.from(_irtData);

    if (order == SortOrder.none) {
      if (_selectedCurrency == CurrencyType.tether) {
        _filteredTetherData = dataToSort;
      } else {
        _filteredIrtData = dataToSort;
      }
    } else {
      dataToSort.sort((a, b) {
        double changeA = a.dayChange ?? 0;
        double changeB = b.dayChange ?? 0;
        return order == SortOrder.ascending
            ? changeA.compareTo(changeB)
            : changeB.compareTo(changeA);
      });

      if (_selectedCurrency == CurrencyType.tether) {
        _filteredTetherData = dataToSort;
      } else {
        _filteredIrtData = dataToSort;
      }
    }
    notifyListeners();
  }

  void sortByVolume(SortOrder order) {
    _volumeOrder[_selectedCurrency] = order;
    _priceOrder[_selectedCurrency] = SortOrder.none;
    _changeOrder[_selectedCurrency] = SortOrder.none;
    _nameOrder[_selectedCurrency] = SortOrder.none;

    List<Crypto> dataToSort = _selectedCurrency == CurrencyType.tether
        ? List.from(_tetherData)
        : List.from(_irtData);

    if (order == SortOrder.none) {
      if (_selectedCurrency == CurrencyType.tether) {
        _filteredTetherData = dataToSort;
      } else {
        _filteredIrtData = dataToSort;
      }
    } else {
      dataToSort.sort((a, b) {
        double volumeA =
            double.tryParse(a.volumeSrc?.replaceAll(',', '') ?? '0') ?? 0;
        double volumeB =
            double.tryParse(b.volumeSrc?.replaceAll(',', '') ?? '0') ?? 0;
        return order == SortOrder.ascending
            ? volumeA.compareTo(volumeB)
            : volumeB.compareTo(volumeA);
      });

      if (_selectedCurrency == CurrencyType.tether) {
        _filteredTetherData = dataToSort;
      } else {
        _filteredIrtData = dataToSort;
      }
    }
    notifyListeners();
  }

  void sortByName(SortOrder order) {
    _nameOrder[_selectedCurrency] = order;
    _priceOrder[_selectedCurrency] = SortOrder.none;
    _volumeOrder[_selectedCurrency] = SortOrder.none;
    _changeOrder[_selectedCurrency] = SortOrder.none;

    List<Crypto> dataToSort = _selectedCurrency == CurrencyType.tether
        ? List.from(_tetherData)
        : List.from(_irtData);

    if (order == SortOrder.none) {
      if (_selectedCurrency == CurrencyType.tether) {
        _filteredTetherData = dataToSort;
      } else {
        _filteredIrtData = dataToSort;
      }
    } else {
      dataToSort.sort((a, b) {
        return order == SortOrder.ascending
            ? a.symbol!.compareTo(b.symbol!)
            : b.symbol!.compareTo(a.symbol!);
      });

      if (_selectedCurrency == CurrencyType.tether) {
        _filteredTetherData = dataToSort;
      } else {
        _filteredIrtData = dataToSort;
      }
    }
    notifyListeners();
  }

  // بقیه متدهای مرتب‌سازی به همین شکل آپدیت می‌شوند...

  // متد اصلی دریافت داده‌ها
  Future<void> fetchCoins() async {
    try {
      _isLoading = true;
      notifyListeners();

      final resultCoinRanking = await _cryptoCoinRanking.getState();

      // دریافت داده‌های تتری و تومانی به صورت همزمان
      final resultNobitexIRT = await _cryptoNobitex.getState('rls');
      final resultNobitexUSDT = await _cryptoNobitex.getState('usdt');

      final nobitexStatsIRT = resultNobitexIRT['stats'] as Map<String, dynamic>;
      final nobitexStatsUSDT =
          resultNobitexUSDT['stats'] as Map<String, dynamic>;

      final coins = resultCoinRanking['data']['coins'] as List;

      _tetherData = [];
      _irtData = [];

      for (var coin in coins) {
        final symbol = coin['symbol'].toString().toLowerCase();
        final nobitexSymbolIRT = '$symbol-rls';
        final nobitexSymbolUSDT = '$symbol-usdt';

        // پردازش داده‌های تومانی
        if (nobitexStatsIRT.containsKey(nobitexSymbolIRT)) {
          final cryptoStats = nobitexStatsIRT[nobitexSymbolIRT];
          var rawPrice = double.tryParse(cryptoStats['latest'].toString());
          String? formattedPrice;
          if (rawPrice != null) {
            var dividedPrice = (rawPrice / 10).toString();
            formattedPrice = formatPrice(dividedPrice);
          }


          _irtData.add(Crypto(
            coin['name'],
            formattedPrice,
            double.tryParse(cryptoStats['dayChange'].toString()),
            coin['marketCap'],
            null,
            null,
            null,
            null,
            null,
            null,
            formatVolumeDst(cryptoStats['volumeDst']).toString(),
            null,
            null,
            coin['iconUrl'],
            coin['symbol'],
            coin['color'],
          ));
        }

        // پردازش داده‌های تتری
        if (nobitexStatsUSDT.containsKey(nobitexSymbolUSDT)) {
          final cryptoStats = nobitexStatsUSDT[nobitexSymbolUSDT];
          String? formattedPrice =
              formatPrice(cryptoStats['latest'].toString());

          _tetherData.add(Crypto(
            coin['name'],
            formattedPrice,
            double.tryParse(cryptoStats['dayChange'].toString()),
            coin['marketCap'],
            null,
            null,
            null,
            null,
            null,
            null,
            formatVolumeDst(cryptoStats['volumeDst']).toString(),
            null,
            null,
            coin['iconUrl'],
            coin['symbol'],
            coin['color'],
          ));
        }
      }

      _filteredTetherData = List.from(_tetherData);
      _filteredIrtData = List.from(_irtData);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching crypto data: $e');
      _isLoading = false;
      notifyListeners();
    }
  }
}
