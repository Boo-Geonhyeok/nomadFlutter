import 'package:flutter/material.dart';
import 'package:nomadflutter/Widgets/button.dart';
import 'package:nomadflutter/Widgets/card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("GHBOO",
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                        Text("welcome back",
                            style: TextStyle(
                              color: Colors.pink.shade400,
                              fontSize: 20,
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Total Balance",
                  style: TextStyle(
                    color: Colors.pink.shade400,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "\$1,000,000",
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 42,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: "Transfer",
                      textColor: Colors.green,
                      backgroundColor: Colors.white,
                    ),
                    Button(
                      text: "Request",
                      textColor: Colors.green,
                      backgroundColor: Colors.lime.shade300,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Wallets",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "view all",
                      style: TextStyle(
                        color: Colors.pink.shade400,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CurrencyCard(
                  currency: "Euro",
                  balance: "6,428",
                  currencyAbbr: "EUR",
                  currencyIcon: Icons.euro,
                  order: 0,
                ),
                CurrencyCard(
                  currency: "Yen",
                  balance: "2,032",
                  currencyAbbr: "JPY",
                  currencyIcon: Icons.currency_yen,
                  order: 1,
                ),
                CurrencyCard(
                  currency: "Bitcoin",
                  balance: "527",
                  currencyAbbr: "BTC",
                  currencyIcon: Icons.currency_bitcoin,
                  order: 2,
                )
              ],
            )),
      ),
    );
  }
}
