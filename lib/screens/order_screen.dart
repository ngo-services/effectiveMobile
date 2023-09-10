import 'package:effectivemobile/main_screen.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Заказ оплачен',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.2000000212,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 94,
              width: 94,
              decoration: BoxDecoration(
                color: const Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Image.asset('assets/icons/Party Popper.png',
                  height: 44, width: 44),
            ),
            const SizedBox(height: 32),
            const Text(
              'Ваш заказ принят в работу',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'SF Pro Display',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SF Pro Display',
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          // if (_formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
          // }
        },
        child: Container(
          height: 88,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 16,
                right: 16,
                top: 15,
                bottom: 15,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      'Супер!',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.2,
                        fontFamily: 'SF Pro Display',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
