import 'dart:async';
import 'package:crypto/widgets/button_widget.dart';
import 'package:crypto/widgets/design/coin_card.dart';
import 'package:flutter/material.dart';
import 'widgets/total_balance.dart';
//import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/coins.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception("Failed to load, try again");
    }
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(const Duration(seconds: 10), ((timer) => fetchCoin()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: TotalBalance(),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(active: true, onTap: () {}, text: 'Deposit'),
                  ButtonWidget(active: false, onTap: () {}, text: 'Withdraw'),
                  ButtonWidget(active: false, onTap: () {}, text: 'Wallet'),
                ],
              ),
            )),
            SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.3,
                child: ListView.builder(
                    itemCount: coinList.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: CoinCard(
                            change: coinList[index].change.toDouble(),
                            changePercentage:
                                coinList[index].changePercentage.toDouble(),
                            image: coinList[index].image,
                            name: coinList[index].name,
                            price: coinList[index].price.toDouble(),
                            rank: coinList[index].rank.toInt(),
                            symbol: coinList[index].symbol),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
