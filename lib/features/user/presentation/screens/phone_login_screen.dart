import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_button.dart';
import 'package:freshpick/core/common/common_textfield.dart';
import 'package:freshpick/core/common/common_loader.dart';
import 'package:freshpick/core/utils/validators.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/top_curve_clipper.dart';
import '../widgets/auth_header.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool show = false;
  final String _selectedCountryCode = '+91';

  final List<Map<String, String>> _countryCodes = [
    {'code': '+91', 'flag': '🇮🇳', 'name': 'India'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        show = true;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String get _currentFlag => _countryCodes.firstWhere(
    (c) => c['code'] == _selectedCountryCode,
  )['flag']!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// Logo Section
            const AuthHeader(),

            const SizedBox(height: 20),

            Expanded(
              child: AnimatedSlide(
                offset: show ? Offset.zero : const Offset(0, 1),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: ClipPath(
                  clipper: TopCurveClipper(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 24,
                          offset: const Offset(0, -8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 48),

                          /// Title & Subtitle
                          Column(
                            children: [
                              Text(
                                "What's your number?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.textDark,
                                  height: 1.2,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "We'll send you a verification code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.textGrey,
                                  height: 1.4,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),

                                /// Phone Number Input
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Country Code Picker
                                    Container(
                                      height: 54,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.06,
                                            ),
                                            blurRadius: 16,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _currentFlag,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            _selectedCountryCode,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    /// Phone Number Field
                                    Expanded(
                                      child: CommonTextField(
                                        controller: _phoneController,
                                        hintText: 'Enter phone number',
                                        keyboardType: TextInputType.phone,
                                        maxLength: 10,
                                        textInputAction: TextInputAction.done,
                                        prefixIcon: Icon(
                                          Icons.phone_rounded,
                                          size: 20,
                                          color: AppColors.primary,
                                        ),
                                        validator: (val) =>
                                            AppValidators.validatePhone(val),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                /// Continue Button
                                PrimaryButton(
                                  text: "Continue",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      CommonLoader.show(context);
                                      Future.delayed(
                                        const Duration(seconds: 2),
                                        () {
                                          if (mounted) {
                                            CommonLoader.hide(context);
                                            Navigator.pushNamed(
                                              context,
                                              AppRoutes.otpVerification,
                                              arguments:
                                                  '$_selectedCountryCode ${_phoneController.text}',
                                            );
                                          }
                                        },
                                      );
                                    }
                                  },
                                ),
                                const Spacer(),

                                /// Browse as Guest
                                Material(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.25,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "Browse as Guest",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
