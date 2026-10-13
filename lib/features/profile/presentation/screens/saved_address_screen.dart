import 'package:flutter/material.dart';
import '../../../../core/common/common_header.dart';
import '../../../../core/common/common_button.dart';
import '../widgets/address_form_bottomsheet.dart';
import '../widgets/address_list_item.dart';

class SavedAddressScreen extends StatefulWidget {
  const SavedAddressScreen({super.key});

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  final List<Map<String, dynamic>> _addresses = [
    {
      'id': '1',
      'label': 'Home',
      'address': '123 Fresh Street, Green Valley, NY 10001',
      'isDefault': true,
      'icon': Icons.home_rounded,
    },
    {
      'id': '2',
      'label': 'Work',
      'address': '456 Office Plaza, Business District, NY 10002',
      'isDefault': false,
      'icon': Icons.work_rounded,
    },
  ];

  Future<void> _openAddressForm({int? index}) async {
    final saved = await showAddressFormBottomSheet(
      context,
      address: index != null ? _addresses[index] : null,
    );
    if (saved == null || !mounted) return;

    setState(() {
      // Only one address can be the default.
      if (saved['isDefault'] == true) {
        for (final address in _addresses) {
          address['isDefault'] = false;
        }
      }
      if (index != null) {
        _addresses[index] = saved;
      } else {
        _addresses.add(saved);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CommonHeader(title: 'Saved Addresses'),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  final address = _addresses[index];
                  return AddressListItem(
                    address: address,
                    onEdit: () => _openAddressForm(index: index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CommonButton(
          text: 'Add New Address',
          icon: Icons.add_rounded,
          onPressed: () => _openAddressForm(),
        ),
      ),
    );
  }
}
