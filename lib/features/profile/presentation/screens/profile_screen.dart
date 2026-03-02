import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_button.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/common_animated_section.dart';
import '../../../../core/common/common_section_header.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/settings_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'My Profile',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textDark,
                  letterSpacing: -1,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonAnimatedSection(
                      index: 0,
                      child: const ProfileInfoCard(
                        name: 'Atul Developer',
                        email: 'user@dev.com',
                        imageUrl:
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&q=80',
                        membershipType: 'Premium Member',
                      ),
                    ),
                    const SizedBox(height: 32),

                    CommonAnimatedSection(
                      index: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonSectionHeader(title: 'Orders & Wishlist'),
                          const SizedBox(height: 12),
                          SettingsCard(
                            children: [
                              SettingsTile(
                                icon: Icons.shopping_bag_outlined,
                                title: 'My Orders',
                                subtitle: 'View your order history',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.orders,
                                  );
                                },
                              ),
                              const SettingsDivider(),
                              SettingsTile(
                                icon: Icons.favorite_border_rounded,
                                title: 'My Wishlist',
                                subtitle: 'Your saved items',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.wishlist,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    CommonAnimatedSection(
                      index: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonSectionHeader(title: 'Account Settings'),
                          const SizedBox(height: 12),
                          SettingsCard(
                            children: [
                              SettingsTile(
                                icon: Icons.person_outline_rounded,
                                title: 'Edit Profile',
                                subtitle: 'Update your information',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.editProfile,
                                  );
                                },
                              ),
                              const SettingsDivider(),
                              SettingsTile(
                                icon: Icons.location_on_outlined,
                                title: 'Saved Addresses',
                                subtitle: 'Manage delivery addresses',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.savedAddress,
                                  );
                                },
                              ),
                              const SettingsDivider(),
                              SettingsTile(
                                icon: Icons.payment_outlined,
                                title: 'Payment Methods',
                                subtitle: 'Manage your cards',
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.paymentMethods,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    CommonAnimatedSection(
                      index: 3,
                      child: CommonButton(
                        text: 'Log Out',
                        onPressed: () {},
                        icon: Icons.logout_rounded,
                        textColor: AppColors.white,
                        backgroundColor: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
