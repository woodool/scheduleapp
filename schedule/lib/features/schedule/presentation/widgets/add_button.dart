import 'package:flutter/material.dart';

class MenuItem {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const MenuItem({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });
}

class AddButton extends StatefulWidget {
  final List<MenuItem> menuItems;

  const AddButton({
    super.key,
    required this.menuItems,
  });

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        if (_isMenuOpen)
          Positioned(
            bottom: 68,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < widget.menuItems.length; i++) ...[
                  if (i > 0) const SizedBox(height: 10),
                  _buildMenuItem(widget.menuItems[i]),
                ],
              ],
            ),
          ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF0062FF),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _toggleMenu,
              customBorder: const CircleBorder(),
              child: Center(
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 300),
                  turns: _isMenuOpen ? 0.125 : 0,
                  child: Image.asset(
                    'assets/images/add.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _toggleMenu();
            item.onTap();
          },
          borderRadius: BorderRadius.circular(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: -0.025,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF0062FF),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    item.imagePath,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 