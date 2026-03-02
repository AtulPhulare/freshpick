import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_button.dart';
import 'package:freshpick/core/common/common_loader.dart';
import 'package:freshpick/core/common/common_icon_button.dart';
import 'package:freshpick/core/common/common_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/top_curve_clipper.dart';
import '../widgets/auth_header.dart';
import '../widgets/address_label_chip.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressController = TextEditingController();

  bool show = false;
  String selectedLabel = 'Home';

  GoogleMapController? _mapController;
  final LatLng _currentPosition = const LatLng(
    18.5204,
    73.8567,
  ); // Pune coordinates

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
    _addressController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _getCurrentLocation() {
    _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: CommonIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.pop(context),
                backgroundColor: AppColors.white,
                iconColor: AppColors.primary,
                size: 40,
                iconSize: 18,
                borderRadius: 12,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 40),

                /// Logo Section
                const AuthHeader(),

                const SizedBox(height: 20),

                /// White Card
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
                          horizontal: 18,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
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

                            /// Title
                            Text(
                              "Select Your Location",
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: AppColors.textDark,
                                letterSpacing: -0.5,
                                height: 1.2,
                              ),
                            ),

                            const SizedBox(height: 8),

                            /// Subtitle
                            Text(
                              "Pin your delivery address on the map",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: AppColors.textGrey,
                                letterSpacing: 0.2,
                              ),
                            ),

                            const SizedBox(height: 24),

                            /// Search Bar and Location Button
                            CommonSearchBar(
                              hintText: 'Search your address',
                              rightIcon: Icons.my_location_rounded,
                              onRightIconTap: _getCurrentLocation,
                            ),

                            const SizedBox(height: 20),

                            /// Content - Fixed Layout
                            Expanded(
                              child: Column(
                                children: [
                                  /// Google Map with Center Pin
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Stack(
                                        children: [
                                          GoogleMap(
                                            onMapCreated: _onMapCreated,
                                            initialCameraPosition:
                                                CameraPosition(
                                                  target: _currentPosition,
                                                  zoom: 15.0,
                                                ),
                                            myLocationEnabled: true,
                                            myLocationButtonEnabled: false,
                                            zoomControlsEnabled: false,
                                            mapToolbarEnabled: false,
                                          ),

                                          /// 📍 Center Pin
                                          Center(
                                            child: Icon(
                                              Icons.location_pin,
                                              size: 50,
                                              color: AppColors.error,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.3),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  /// Address Details Section
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: AppColors.background,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// Selected Address Preview
                                          Text(
                                            "DELIVERY ADDRESS",
                                            style: TextStyle(
                                              color: AppColors.textGrey,
                                              fontSize: 11,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Expanded(
                                            child: Text(
                                              "123 Green Market Road, Pune, Maharashtra 411001",
                                              style: TextStyle(
                                                color: AppColors.textDark,
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 1.4,
                                                letterSpacing: 0.2,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Spacer(),

                                          /// 🏷️ Address Labels
                                          Row(
                                            children: [
                                              AddressLabelChip(
                                                label: "Home",
                                                isSelected:
                                                    selectedLabel == "Home",
                                                onTap: () => setState(
                                                  () => selectedLabel = "Home",
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              AddressLabelChip(
                                                label: "Work",
                                                isSelected:
                                                    selectedLabel == "Work",
                                                onTap: () => setState(
                                                  () => selectedLabel = "Work",
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              AddressLabelChip(
                                                label: "Other",
                                                isSelected:
                                                    selectedLabel == "Other",
                                                onTap: () => setState(
                                                  () => selectedLabel = "Other",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// Confirm Button
                            PrimaryButton(
                              text: 'Confirm Address',
                              onPressed: () {
                                CommonLoader.show(context);
                                Future.delayed(const Duration(seconds: 2), () {
                                  if (mounted) {
                                    CommonLoader.hide(context);
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.home,
                                    );
                                  }
                                });
                              },
                            ),

                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
