import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshpick/core/common/common_button.dart';
import 'package:freshpick/core/common/common_loader.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/top_curve_clipper.dart';
import '../widgets/auth_header.dart';
import '../widgets/otp_input_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool show = false;
  int _resendTimer = 30;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => show = true);
      _focusNodes[0].requestFocus();
    });
    _startResendTimer();
  }

  void _startResendTimer() {
    _resendTimer = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();
  bool get _isOtpComplete => _otpCode.length == 6;

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    setState(() {});
  }

  void _onKeyPressed(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verifyOtp() async {
    if (!_isOtpComplete) return;
    CommonLoader.show(context);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    CommonLoader.hide(context);

    Navigator.pushReplacementNamed(context, AppRoutes.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
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
                            child: Column(
                              children: [
                                const SizedBox(height: 48),

                                /// Title & Subtitle
                                Column(
                                  children: [
                                    Text(
                                      "Verify Your Number",
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
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.textGrey,
                                          height: 1.5,
                                          letterSpacing: 0.2,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text:
                                                'Enter the 6-digit code sent to\n',
                                          ),
                                          TextSpan(
                                            text: widget.phoneNumber,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20),

                                      /// OTP Input Fields
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(6, (index) {
                                          return OtpInputField(
                                            controller: _controllers[index],
                                            focusNode: _focusNodes[index],
                                            isFilled: _controllers[index]
                                                .text
                                                .isNotEmpty,
                                            isFocused:
                                                _focusNodes[index].hasFocus,
                                            index: index,
                                            onChanged: _onOtpChanged,
                                            onKeyPressed: _onKeyPressed,
                                          );
                                        }),
                                      ),

                                      const SizedBox(height: 28),

                                      /// Resend Timer
                                      _resendTimer > 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.schedule_rounded,
                                                  size: 16,
                                                  color: AppColors.textGrey,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Resend code in ',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.textGrey,
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryLight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    '0:${_resendTimer.toString().padLeft(2, '0')}',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                _startResendTimer();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.refresh_rounded,
                                                    size: 18,
                                                    color: AppColors.primary,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    'Resend Code',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.primary,
                                                      letterSpacing: 0.3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                      const SizedBox(height: 36),

                                      /// Verify Button
                                      AnimatedOpacity(
                                        opacity: _isOtpComplete ? 1.0 : 0.5,
                                        duration: const Duration(
                                          milliseconds: 50,
                                        ),
                                        child: PrimaryButton(
                                          text: _isVerifying
                                              ? "Verifying..."
                                              : "Verify & Continue",
                                          icon: _isVerifying
                                              ? null
                                              : Icons.verified_rounded,
                                          onPressed: _isOtpComplete
                                              ? _verifyOtp
                                              : null,
                                        ),
                                      ),

                                      const Spacer(),

                                      /// Change Number
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit_rounded,
                                              size: 16,
                                              color: AppColors.primary,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "Change phone number",
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
