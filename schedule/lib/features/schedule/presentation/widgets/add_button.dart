import 'package:flutter/material.dart';

class MenuItem {
  final String imagePath;
  final String label;
  final String routeName;
  final Widget page;

  const MenuItem({
    required this.imagePath,
    required this.label,
    required this.routeName,
    required this.page,
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
                  _buildMenuItem(context, widget.menuItems[i]),
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
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _toggleMenu();
          Navigator.pushNamed(context, item.routeName);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                  letterSpacing: -0.025,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              Image.asset(
                item.imagePath,
                width: 48,
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
