import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  String currency;
  String balance;
  String currencyAbbr;
  IconData currencyIcon;
  double order;

  CurrencyCard({
    super.key,
    required this.currency,
    required this.balance,
    required this.currencyAbbr,
    required this.currencyIcon,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, order * -20),
      child: Container(
        decoration: BoxDecoration(
          color: order % 2 == 1 ? Colors.white : Colors.lime.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currency,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "$balance ",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      currencyAbbr,
                      style: TextStyle(
                        color: Colors.green.shade300,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Transform.scale(
              scale: 2.3,
              child: Transform.translate(
                offset: const Offset(-7, 8),
                child: Icon(
                  currencyIcon,
                  color: Colors.green,
                  size: 98,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
