import 'package:flutter/material.dart';
import '../../../../core/common/common_header.dart';
import '../../../../core/common/common_button.dart';
import '../../../../core/common/common_section_header.dart';
import '../widgets/payment_method_list_item.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': '1',
      'type': 'Visa',
      'number': '**** **** **** 4242',
      'expiry': '12/25',
      'isDefault': true,
      'color': const Color(0xFF1A1F71), // Visa Blue
      'logo': Icons.credit_card_rounded,
    },
    {
      'id': '2',
      'type': 'Mastercard',
      'number': '**** **** **** 5555',
      'expiry': '09/24',
      'isDefault': false,
      'color': const Color(0xFFEB001B), // Mastercard Red
      'logo': Icons.credit_card_rounded,
    },
    {
      'id': '3',
      'type': 'Apple Pay',
      'number': 'johndoe@icloud.com',
      'isDefault': false,
      'color': Colors.black,
      'logo': Icons.apple_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CommonHeader(title: 'Payment Methods'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const CommonSectionHeader(title: 'Your Cards'),
                  const SizedBox(height: 12),
                  ..._paymentMethods
                      .where((m) => m['type'] != 'Apple Pay')
                      .map(
                        (card) => PaymentMethodListItem(
                          method: card,
                          onMoreTap: () {},
                        ),
                      ),
                  const SizedBox(height: 24),
                  const CommonSectionHeader(title: 'Digital Wallets'),
                  const SizedBox(height: 12),
                  ..._paymentMethods
                      .where((m) => m['type'] == 'Apple Pay')
                      .map(
                        (wallet) => PaymentMethodListItem(
                          method: wallet,
                          onMoreTap: () {},
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CommonButton(
          text: 'Add New Method',
          icon: Icons.add_rounded,
          onPressed: () {
            // Handle add payment method
          },
        ),
      ),
    );
  }
}
