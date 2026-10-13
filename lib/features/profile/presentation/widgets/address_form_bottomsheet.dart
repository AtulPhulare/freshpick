import 'package:flutter/material.dart';

import '../../../../core/common/common_button.dart';
import '../../../../core/common/common_textfield.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../user/presentation/widgets/address_label_chip.dart';

const List<String> _labels = ['Home', 'Work', 'Other'];

IconData addressIconFor(String label) {
  switch (label) {
    case 'Home':
      return Icons.home_rounded;
    case 'Work':
      return Icons.work_rounded;
    default:
      return Icons.location_on_rounded;
  }
}

/// Opens the add / edit address sheet.
/// Pass [address] to edit an existing one. Resolves to the saved address,
/// or `null` when dismissed.
Future<Map<String, dynamic>?> showAddressFormBottomSheet(
  BuildContext context, {
  Map<String, dynamic>? address,
}) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddressFormBottomSheet(address: address),
  );
}

class AddressFormBottomSheet extends StatefulWidget {
  final Map<String, dynamic>? address;

  const AddressFormBottomSheet({super.key, this.address});

  @override
  State<AddressFormBottomSheet> createState() => _AddressFormBottomSheetState();
}

class _AddressFormBottomSheetState extends State<AddressFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _addressController;
  late final TextEditingController _customLabelController;
  late String _selectedLabel;
  late bool _isDefault;

  bool get _isEditing => widget.address != null;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(
      text: widget.address?['address'] ?? '',
    );
    // A label that isn't Home/Work was typed by the user under "Other".
    final String savedLabel = widget.address?['label'] ?? 'Home';
    final isCustom = !_labels.contains(savedLabel);
    _selectedLabel = isCustom ? 'Other' : savedLabel;
    _customLabelController = TextEditingController(
      text: isCustom ? savedLabel : '',
    );
    _isDefault = widget.address?['isDefault'] ?? false;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _customLabelController.dispose();
    super.dispose();
  }

  void _save() {
    // CommonTextField only displays the error, so check the value here too.
    _formKey.currentState!.validate();
    final text = _addressController.text.trim();
    final customLabel = _customLabelController.text.trim();
    final isOther = _selectedLabel == 'Other';
    if (text.isEmpty || (isOther && customLabel.isEmpty)) return;

    Navigator.pop(context, {
      'id':
          widget.address?['id'] ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      'label': isOther ? customLabel : _selectedLabel,
      'address': text,
      'isDefault': _isDefault,
      'icon': addressIconFor(_selectedLabel),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  _isEditing ? 'Edit Address' : 'Add New Address',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Save as',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    for (final label in _labels) ...[
                      AddressLabelChip(
                        label: label,
                        isSelected: _selectedLabel == label,
                        onTap: () => setState(() => _selectedLabel = label),
                      ),
                      if (label != _labels.last) const SizedBox(width: 10),
                    ],
                  ],
                ),
                if (_selectedLabel == 'Other') ...[
                  const SizedBox(height: 16),
                  CommonTextField(
                    controller: _customLabelController,
                    label: 'Label name',
                    hintText: "e.g. Gym, Mom's place",
                    maxLength: 20,
                    prefixIcon: const Icon(Icons.label_outline_rounded),
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Please enter a label name'
                        : null,
                  ),
                ],
                const SizedBox(height: 20),
                CommonTextField(
                  controller: _addressController,
                  label: 'Address',
                  hintText: 'House no, street, area, city, pincode',
                  maxLines: 3,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter an address'
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Set as default address',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: _isDefault,
                      onChanged: (v) => setState(() => _isDefault = v),
                      activeTrackColor: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CommonButton(
                  text: _isEditing ? 'Update Address' : 'Save Address',
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
