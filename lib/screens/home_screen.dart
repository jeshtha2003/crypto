import 'package:flutter/material.dart';
import 'package:flutter_crypto/controllers/coin_controller.dart';
import 'package:flutter_crypto/utils.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final CoinController controller = Get.put(CoinController());
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        backgroundColor: const Color(0xff494F55),
        body: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Crypto Market",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        // ignore: prefer_const_constructors
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                // ignore: prefer_const_constructors
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[700],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey[700]!,
                                                    offset: const Offset(4, 4),
                                                    blurRadius: 5)
                                              ]),
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Image.network(controller
                                                  .coinsList[index].image)),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              controller.coinsList[index].name,
                                              style: textStyle(18, Colors.white,
                                                  FontWeight.w600),
                                            ),
                                            Text(
                                              "${controller.coinsList[index].priceChangePercentage24H.toStringAsFixed(2)}%",
                                              style: textStyle(18, Colors.white,
                                                  FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "\u{20B9}${controller.coinsList[index].currentPrice.round()}",
                                          style: textStyle(18, Colors.white,
                                              FontWeight.w600),
                                        ),
                                        Text(
                                          controller.coinsList[index].symbol
                                              .toUpperCase(),
                                          style: textStyle(18, Colors.white,
                                              FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          );
                        },
                      ),
              )
            ],
          )),
        ));
  }
  //hello
}
