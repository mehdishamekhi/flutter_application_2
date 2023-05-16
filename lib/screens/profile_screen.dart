import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
              child: Container(
                width: 340,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Image.asset('assets/images/icon_apple_blue.png'),
                      const SizedBox(
                        width: 95,
                      ),
                      const Text(
                        'حساب کاربری',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: CustomColor.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              'مهدی شامخی',
              style: TextStyle(fontSize: 18, fontFamily: 'SB'),
            ),
            const Text(
              '09185865917',
              style: TextStyle(
                  fontSize: 12, fontFamily: 'Sm', color: CustomColor.grey),
            ),
            const SizedBox(
              height: 35,
            ),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    // CategorySingleItem(),
                    // CategorySingleItem(),
                    // CategorySingleItem(),
                    // CategorySingleItem(),
                    // CategorySingleItem(),
                    // CategorySingleItem(),
                    // CategorySingleItem(),
                    // CategorySingleItem(),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'sm',
                color: CustomColor.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'V_10.00',
              style: TextStyle(
                fontSize: 12,
                color: CustomColor.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'instagram.com/mehdishamekhi',
              style: TextStyle(
                fontSize: 12,
                color: CustomColor.grey,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
