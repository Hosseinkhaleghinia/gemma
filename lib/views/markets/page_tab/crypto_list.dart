import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemma/assets/colors.dart';
import 'package:gemma/models/crypto_state.dart';
import 'package:gemma/views/markets/page_tab/market_map.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/crypto_data_provider.dart';

// Constants
const double AVATAR_RADIUS = 20.0;
const double FILTER_ICON_WIDTH = 15.0;
const double PRICE_CHANGE_HEIGHT_FACTOR = 0.07;
const int LOADING_TIMEOUT_SECONDS = 5;

// Enums
enum FilterState { none, ascending, descending }

// Models
class CryptoFilterButton {
  final String title;
  FilterState state;

  CryptoFilterButton(this.title, [this.state = FilterState.none]);
}

class CryptoList extends StatefulWidget {
  const CryptoList({super.key});

  @override
  State<CryptoList> createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  final Map<String, CryptoFilterButton> _filterButtons = {
    '24h تغییر': CryptoFilterButton('24h تغییر'),
    'آخرین قیمت': CryptoFilterButton('آخرین قیمت'),
    'حجم': CryptoFilterButton('حجم'),
    'رمزارز': CryptoFilterButton('رمزارز'),
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // اضافه کردن listener برای تب‌ها
    _tabController?.addListener(() {
      if (_tabController?.indexIsChanging ?? false) {
        final provider = Provider.of<CryptoDataProvider>(context, listen: false);
        provider.setSelectedCurrency(
            _tabController?.index == 0 ? CurrencyType.tether : CurrencyType.irt
        );
      }
    });

    _initializeCryptoData();
  }

  void _initializeCryptoData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CryptoDataProvider>(context, listen: false);
      provider.setSelectedCurrency(
          _tabController?.index == 0 ? CurrencyType.tether : CurrencyType.irt);
      provider.fetchCoins();
    });
  }


  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<CryptoDataProvider>(
      builder: (context, cryptoProvider, child) {
        return Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // اگر تب فعلی تتری است، لیست تتری را ارسال می‌کنیم
                      // در غیر این صورت لیست تومانی ارسال می‌شود
                      final data = _tabController?.index == 0
                          ? cryptoProvider.getTetherList()
                          : cryptoProvider.getIRTList();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MarketMapWidget(
                            data: data,
                            currencyType: _tabController!.index == 0
                                ? CurrencyType.tether
                                : CurrencyType.irt,
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_sharp,
                          size: 14,
                          color: Colors.black,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'نقشه بازار',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (width - 20) * 0.5,
                    child: TabBar(
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('تتری'),
                              const SizedBox(width: 8),
                              SvgPicture.asset(
                                'images/usdt.svg',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('تومانی'),
                              const SizedBox(width: 8),
                              SvgPicture.asset(
                                'images/iran.svg',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                      controller: _tabController,
                      labelColor: blue20Safaii,
                      unselectedLabelColor: Colors.grey,
                      indicator: BoxDecoration(
                        border: Border.all(style: BorderStyle.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
              height: 1,
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTabContent(width, true), // تتری
                  _buildTabContent(width, false), // تومانی
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabContent(double width, bool isTether) {
    return Consumer<CryptoDataProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: SpinKitCircle(
              size: 70,
              color: Colors.blue,
            ),
          );
        }

        final cryptoList = isTether ? provider.getTetherList() : provider.getIRTList();

        if (cryptoList.isEmpty) {
          return const Center(
            child: Text('هیچ داده‌ای یافت نشد'),
          );
        }

        return Column(
          children: [
            _buildFilterSection(width),
            Expanded(
              child: ListView.builder(
                itemCount: cryptoList.length,
                itemBuilder: (context, index) {
                  return _buildCryptoListItem(width, cryptoList[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const SpinKitCircle(
      size: 70,
      color: Colors.blue,
    );
  }

  Widget _buildMainContent(double width, CryptoDataProvider provider) {
    return Column(
      children: [
        TabBar(controller: _tabController, tabs: [
          Tab(text: 'تتری', icon: SvgPicture.asset('images/usdt.svg')),
          Tab(text: 'تومانی', icon: SvgPicture.asset('images/iran.svg')),
        ]),
        TabBarView(controller: _tabController, children: [
          Column(
            children: [
              _buildFilterSection(width),
              Expanded(
                child: _buildTabContent(width, true),
              ),
            ],
          ),
          Column(
            children: [
              _buildFilterSection(width),
              Expanded(
                child: _buildTabContent(width, false),
              ),
            ],
          ),
        ])
      ],
    );
  }

  Widget _buildFilterSection(double width) {
    final buttonWidth = width - 20;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: buttonWidth * 0.18,
          child: _buildFilterButton(_filterButtons['24h تغییر']!),
        ),
        SizedBox(width: buttonWidth * 0.08),
        SizedBox(
          width: buttonWidth * 0.29,
          child: _buildFilterButton(_filterButtons['آخرین قیمت']!),
        ),
        SizedBox(
          width: buttonWidth * 0.45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildFilterButton(_filterButtons['حجم']!),
              const Text(' / '),
              _buildFilterButton(_filterButtons['رمزارز']!),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(CryptoFilterButton button) {
    return InkWell(
      onTap: () => _handleFilterTap(button),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterIcon(button.state),
          const SizedBox(width: 2),
          Text(
            button.title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterIcon(FilterState state) {
    switch (state) {
      case FilterState.none:
        return SvgPicture.asset(
          'images/equal.svg',
          fit: BoxFit.fill,
          width: FILTER_ICON_WIDTH,
        );
      case FilterState.ascending:
      case FilterState.descending:
        return Transform.rotate(
          angle: state == FilterState.ascending ? 0 : 3.14159,
          child: Shimmer.fromColors(
            baseColor: Colors.blueAccent,
            highlightColor: Colors.grey,
            direction: ShimmerDirection.btt,
            child: SvgPicture.asset(
              'images/upward.svg',
              fit: BoxFit.fill,
              width: FILTER_ICON_WIDTH,
            ),
          ),
        );
    }
  }

  // Widget _buildCryptoList(double width, CryptoDataProvider provider) {
  //   return ListView.builder(
  //     itemCount: cryptoLi ,
  //     itemBuilder: (context, index) {
  //       final crypto = provider.cryptoData[index];
  //       return _buildCryptoListItem(width, crypto);
  //     },
  //   );
  // }

  Widget _buildCryptoListItem(double width, Crypto crypto) {
    return SizedBox(
      height: width * 0.17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          _buildCryptoInfo(width, crypto),
          _buildPriceInfo(width, crypto.latestPrice),
          SizedBox(width: (width - 20) * 0.08),
          _buildPriceChange(width, crypto.dayChange),
        ],
      ),
    );
  }

  Widget _buildCryptoInfo(double width, Crypto crypto) {
    return SizedBox(
      width: (width - 20) * 0.45,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          _buildCryptoAvatar(crypto),
          const SizedBox(width: 10),
          _buildCryptoDetails(crypto),
        ],
      ),
    );
  }

  Widget _buildCryptoAvatar(Crypto crypto) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: AVATAR_RADIUS,
      child: SvgPicture.network(
        crypto.iconUrl!,
        placeholderBuilder: (context) => _buildAvatarPlaceholder(crypto),
      ),
    );
  }

  Widget _buildAvatarPlaceholder(Crypto crypto) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: LOADING_TIMEOUT_SECONDS)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            decoration: BoxDecoration(
              color: hexToColor(crypto.color!),
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                colors: [
                  hexToColor(crypto.color!),
                  hexToColor(crypto.color!).withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          );
        }
        return const SpinKitCircle(
          color: Colors.blue,
          size: 20,
        );
      },
    );
  }

  Widget _buildCryptoDetails(Crypto crypto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(crypto.symbol!, style: const TextStyle(fontSize: 14)),
            const Text(
              ' / IRT',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        Text(
          crypto.volumeSrc?.toString() ?? 'Unavailable',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInfo(double width, String? price) {
    return SizedBox(
      width: (width - 20) * 0.29,
      child: Text(
        price ?? 'Unavailable',
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPriceChange(double width, dynamic change) {
    final double? numericChange = _parseChange(change);
    final color = _getPriceChangeColor(numericChange);

    return SizedBox(
      width: (width - 20) * 0.18,
      child: Container(
        width: width * 0.15,
        height: width * PRICE_CHANGE_HEIGHT_FACTOR,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(
            numericChange == null
                ? '0%'
                : '${numericChange.toStringAsFixed(2)}%',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _handleFilterTap(CryptoFilterButton button) {
    final provider = Provider.of<CryptoDataProvider>(context, listen: false);

    setState(() {
      // ابتدا همه دکمه‌های دیگر را به حالت none برمی‌گردانیم
      _filterButtons.forEach((key, filterButton) {
        if (filterButton != button) {
          filterButton.state = FilterState.none;
        }
      });

      // سپس حالت دکمه کلیک شده را تغییر می‌دهیم
      switch (button.state) {
        case FilterState.none:
          button.state = FilterState.ascending;
          break;
        case FilterState.ascending:
          button.state = FilterState.descending;
          break;
        case FilterState.descending:
          button.state = FilterState.none;
          break;
      }

      // اعمال فیلتر مناسب بر اساس نوع دکمه
      final order = _convertFilterStateToSortOrder(button.state);

      switch (button.title) {
        case 'آخرین قیمت':
          provider.sortByPrice(order);
          break;
        case '24h تغییر':
          provider.sortByDayChange(order);
          break;
        case 'حجم':
          provider.sortByVolume(order);
          break;
        case 'رمزارز':
          provider.sortByName(order);
          break;
      }
    });
  }

  SortOrder _convertFilterStateToSortOrder(FilterState state) {
    switch (state) {
      case FilterState.none:
        return SortOrder.none;
      case FilterState.ascending:
        return SortOrder.ascending;
      case FilterState.descending:
        return SortOrder.descending;
    }
  }

  double? _parseChange(dynamic change) {
    if (change == null) return null;
    if (change is double) return change;
    if (change is String) {
      try {
        return double.parse(change);
      } catch (e) {
        debugPrint('Error parsing price change: $e');
        return null;
      }
    }
    return null;
  }

  Color _getPriceChangeColor(double? change) {
    if (change == null || change == 0) return Colors.grey;
    return change > 0 ? Colors.greenAccent : Colors.redAccent;
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    return Color(int.parse("FF$hex", radix: 16));
  }
}