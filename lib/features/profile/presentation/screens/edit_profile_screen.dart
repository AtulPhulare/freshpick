import 'package:flutter/material.dart';
import '../../../../core/common/common_header.dart';
import '../../../../core/common/common_button.dart';
import '../../../../core/common/common_textfield.dart';
import '../../../../core/common/common_loader.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/profile_image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'John Doe');
    _emailController = TextEditingController(text: 'johndoe@example.com');
    _phoneController = TextEditingController(text: '+1 234 567 890');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CommonHeader(title: 'Edit Profile'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Profile Image
                      ProfileImagePicker(
                        imageUrl: 'https://i.pravatar.cc/300',
                        onTap: () {},
                      ),
                      const SizedBox(height: 32),
                      // Form Fields
                      CommonTextField(
                        label: 'Full Name',
                        controller: _nameController,
                        hintText: 'Enter your name',
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        validator: (val) =>
                            AppValidators.validateRequired(val, 'Full Name'),
                      ),
                      const SizedBox(height: 20),
                      CommonTextField(
                        label: 'Email Address',
                        controller: _emailController,
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) => AppValidators.validateEmail(val),
                      ),
                      const SizedBox(height: 20),
                      CommonTextField(
                        label: 'Phone Number',
                        controller: _phoneController,
                        hintText: 'Enter your phone',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        keyboardType: TextInputType.phone,
                        validator: (val) => AppValidators.validatePhone(val),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CommonButton(
          text: 'Save Changes',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              CommonLoader.show(context);
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  CommonLoader.hide(context);
                  Navigator.pop(context);
                }
              });
            }
          },
        ),
      ),
    );
  }
}
