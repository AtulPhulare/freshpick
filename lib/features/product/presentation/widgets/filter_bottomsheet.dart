import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_button.dart';

import '../../../../core/common/common_icon_button.dart';

// ─────────────────────────────────────────────
//  App Colors (inline — remove if you import)
// ─────────────────────────────────────────────
class AppColors {
  static const Color primary = Color(0xFF27AE60);
  static const Color primaryLight = Color(0xFFE8F5E9);
  static const Color accent = Color(0xFFFF8C00);
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textGrey = Color(0xFF757575);
  static const Color background = Color(0xFFF9F9F9);
  static const Color white = Colors.white;
  static const Color berryPastel = Color(0xFFFCE4EC);
  static const Color citrusPastel = Color(0xFFFFF3E0);
  static const Color greenPastel = Color(0xFFF1F8E9);
  static const Color tropicalPastel = Color(0xFFFFFDE7);
}

// ─────────────────────────────────────────────
//  Public entry-point
// ─────────────────────────────────────────────
void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _FilterSheet(),
  );
}

// ─────────────────────────────────────────────
//  Filter sheet
// ─────────────────────────────────────────────
class _FilterSheet extends StatefulWidget {
  const _FilterSheet();

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet>
    with SingleTickerProviderStateMixin {
  // ── state ──────────────────────────────────
  String _selectedSort = 'Relevance';
  final Set<String> _selectedCategories = {'All'};
  final Set<String> _selectedTags = {};
  RangeValues _priceRange = const RangeValues(0, 100);
  double _minRating = 0;

  late AnimationController _animCtrl;
  late Animation<double> _slideAnim;

  // ── data ───────────────────────────────────
  static const _sortOptions = [
    'Relevance',
    'Newest',
    'Price: Low–High',
    'Price: High–Low',
    'Top Rated',
    'Best Seller',
  ];

  static const _categories = [
    ('All', '🛒'),
    ('Fruits', '🍎'),
    ('Vegetables', '🥦'),
    ('Berries', '🍓'),
    ('Citrus', '🍊'),
    ('Tropical', '🍋'),
    ('Organic', '🌿'),
  ];

  static const _tags = [
    'On Sale',
    'New Arrival',
    'Seasonal',
    'Local Farm',
    'No Pesticides',
    'Vegan',
  ];

  // ── lifecycle ──────────────────────────────
  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _slideAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutQuart);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  // ── helpers ────────────────────────────────
  void _resetAll() {
    setState(() {
      _selectedSort = 'Relevance';
      _selectedCategories
        ..clear()
        ..add('All');
      _selectedTags.clear();
      _priceRange = const RangeValues(0, 100);
      _minRating = 0;
    });
  }

  void _applyFilters() => Navigator.pop(context);

  int get _activeCount {
    int c = 0;
    if (_selectedSort != 'Relevance') c++;
    if (!(_selectedCategories.length == 1 &&
        _selectedCategories.contains('All'))) {
      c++;
    }
    if (_selectedTags.isNotEmpty) c++;
    if (_priceRange != const RangeValues(0, 100)) c++;
    if (_minRating > 0) c++;
    return c;
  }

  // ── build ──────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnim,
      builder: (_, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(_slideAnim),
        child: child,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(),
            _buildHeader(),
            const Divider(height: 1, color: Color(0xFFF0F0F0)),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Sort By'),
                    const SizedBox(height: 12),
                    _buildSortChips(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Category'),
                    const SizedBox(height: 12),
                    _buildCategoryChips(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Tags'),
                    const SizedBox(height: 12),
                    _buildTagChips(),
                    const SizedBox(height: 24),
                    _buildPriceRange(),
                    const SizedBox(height: 24),
                    _buildRatingFilter(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ── sub-widgets ────────────────────────────
  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          const Text(
            'Filter & Sort',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              letterSpacing: -0.3,
            ),
          ),
          if (_activeCount > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$_activeCount',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          const Spacer(),
          GestureDetector(
            onTap: _resetAll,
            child: const Text(
              'Reset all',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
        letterSpacing: -0.1,
      ),
    );
  }

  // Sort – horizontal scrollable pill chips
  Widget _buildSortChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _sortOptions.map((option) {
          final selected = _selectedSort == option;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedSort = option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.background,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: selected
                        ? AppColors.primary
                        : const Color(0xFFE8E8E8),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: selected ? AppColors.white : AppColors.textGrey,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Category – emoji icon chips in a wrap
  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _categories.map(((String label, String emoji) cat) {
        final selected = _selectedCategories.contains(cat.$1);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (cat.$1 == 'All') {
                _selectedCategories
                  ..clear()
                  ..add('All');
              } else {
                _selectedCategories.remove('All');
                if (selected) {
                  _selectedCategories.remove(cat.$1);
                  if (_selectedCategories.isEmpty) {
                    _selectedCategories.add('All');
                  }
                } else {
                  _selectedCategories.add(cat.$1);
                }
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? AppColors.primaryLight : AppColors.background,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: selected ? AppColors.primary : const Color(0xFFE8E8E8),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(cat.$2, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  cat.$1,
                  style: TextStyle(
                    color: selected ? AppColors.primary : AppColors.textGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Tags – small badge chips
  Widget _buildTagChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _tags.map((tag) {
        final selected = _selectedTags.contains(tag);
        return GestureDetector(
          onTap: () => setState(() {
            selected ? _selectedTags.remove(tag) : _selectedTags.add(tag);
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFFFF3E0) : AppColors.background,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: selected ? AppColors.accent : const Color(0xFFE8E8E8),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) ...[
                  Icon(
                    Icons.check_circle_rounded,
                    size: 14,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  tag,
                  style: TextStyle(
                    color: selected ? AppColors.accent : AppColors.textGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Price range slider
  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('Price Range'),
            Text(
              '\$${_priceRange.start.toInt()} – \$${_priceRange.end.toInt()}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.primaryLight,
            thumbColor: AppColors.white,
            overlayColor: AppColors.primary.withValues(alpha: 0.12),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 10,
              elevation: 4,
            ),
            trackHeight: 4,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 10,
              elevation: 4,
            ),
          ),
          child: RangeSlider(
            values: _priceRange,
            min: 0,
            max: 100,
            divisions: 20,
            onChanged: (v) => setState(() => _priceRange = v),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '\$0',
              style: TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),
            Text(
              '\$100',
              style: TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  // Minimum rating filter (star row)
  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Minimum Rating'),
        const SizedBox(height: 12),
        Row(
          children: List.generate(5, (i) {
            final starValue = (i + 1).toDouble();
            final filled = _minRating >= starValue;
            return GestureDetector(
              onTap: () => setState(
                () => _minRating = _minRating == starValue ? 0 : starValue,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.only(right: 6),
                width: 46,
                height: 42,
                decoration: BoxDecoration(
                  color: filled
                      ? const Color(0xFFFFFDE7)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: filled
                        ? const Color(0xFFF1C40F)
                        : const Color(0xFFE8E8E8),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      filled ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: filled
                          ? const Color(0xFFF1C40F)
                          : AppColors.textGrey,
                      size: 20,
                    ),
                    Text(
                      '$starValue',
                      style: TextStyle(
                        fontSize: 10,
                        color: filled
                            ? const Color(0xFFF1C40F)
                            : AppColors.textGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        child: Row(
          children: [
            // Close / cancel
            CommonIconButton(
              icon: Icons.close,
              onTap: () => Navigator.pop(context),
              backgroundColor: AppColors.white,
              iconColor: AppColors.primary,
              size: 54,
              iconSize: 22,
              borderRadius: 12,
            ),
            const SizedBox(width: 12),
            // Apply
            Expanded(
              child: PrimaryButton(
                text: _activeCount > 0
                    ? 'Apply $_activeCount Filter${_activeCount > 1 ? 's' : ''}'
                    : 'Show Results',
                onPressed: _applyFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
