import 'package:flutter/material.dart';

class ShopImageCarousel extends StatefulWidget {
  /// List of image URLs to display in the carousel.
  final List<String> imageUrls;

  /// Height of the carousel. Defaults to 260.
  final double height;

  /// Border radius applied to the carousel container.
  final BorderRadius borderRadius;

  const ShopImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 260.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  });

  @override
  State<ShopImageCarousel> createState() => _ShopImageCarouselState();
}

class _ShopImageCarouselState extends State<ShopImageCarousel> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.imageUrls.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return _PlaceholderImage(
        height: widget.height,
        borderRadius: widget.borderRadius,
      );
    }

    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Stack(
          children: [
            // ── Page View ────────────────────────────────────────
            PageView.builder(
              controller: _pageController,
              itemCount: widget.imageUrls.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return _CarouselImage(url: widget.imageUrls[index]);
              },
            ),

            // ── Left Arrow ───────────────────────────────────────
            if (widget.imageUrls.length > 1 && _currentIndex > 0)
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _NavButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: _goToPrevious,
                  ),
                ),
              ),

            // ── Right Arrow ──────────────────────────────────────
            if (widget.imageUrls.length > 1 &&
                _currentIndex < widget.imageUrls.length - 1)
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _NavButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: _goToNext,
                  ),
                ),
              ),

            // ── Indicator Dots ───────────────────────────────────
            if (widget.imageUrls.length > 1)
              Positioned(
                bottom: 14,
                left: 0,
                right: 0,
                child: _IndicatorDots(
                  count: widget.imageUrls.length,
                  currentIndex: _currentIndex,
                ),
              ),

            // ── Image Counter Badge ──────────────────────────────
            if (widget.imageUrls.length > 1)
              Positioned(
                top: 12,
                right: 12,
                child: _CounterBadge(
                  current: _currentIndex + 1,
                  total: widget.imageUrls.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Private: Single carousel image ───────────────────────────────
class _CarouselImage extends StatelessWidget {
  final String url;

  const _CarouselImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: const Color(0xFFF1F5F9),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
              color: const Color(0xFF2563EB),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFF1F5F9),
          child: const Center(
            child: Icon(
              Icons.broken_image_outlined,
              size: 48,
              color: Color(0xFF94A3B8),
            ),
          ),
        );
      },
    );
  }
}

// ── Private: Chevron nav button ───────────────────────────────────
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: const Color(0xFF0F172A)),
      ),
    );
  }
}

// ── Private: Animated indicator dots ─────────────────────────────
class _IndicatorDots extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _IndicatorDots({required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

// ── Private: "1 / 3" counter badge ───────────────────────────────
class _CounterBadge extends StatelessWidget {
  final int current;
  final int total;

  const _CounterBadge({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$current / $total',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ── Private: Empty state placeholder ─────────────────────────────
class _PlaceholderImage extends StatelessWidget {
  final double height;
  final BorderRadius borderRadius;

  const _PlaceholderImage({
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: double.infinity,
        color: const Color(0xFFF1F5F9),
        child: const Center(
          child: Icon(
            Icons.storefront_outlined,
            size: 56,
            color: Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }
}
