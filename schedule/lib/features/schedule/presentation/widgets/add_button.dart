import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final List<AddButtonItem> items;
  final VoidCallback? onItemSelected;

  const AddButton({
    super.key,
    required this.items,
    this.onItemSelected,
  });

  @override
  State<AddButton> createState() => _AddButtonState();
}

class AddButtonItem {
  final String label;
  final String iconPath;
  final String? description;
  final VoidCallback onPressed;

  const AddButtonItem({
    required this.label,
    required this.iconPath,
    this.description,
    required this.onPressed,
  });
}

class _AddButtonState extends State<AddButton> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _handleItemTap(VoidCallback onPressed) {
    _toggleMenu();
    onPressed();
    widget.onItemSelected?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_isMenuOpen)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widget.items.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: TextButton(
                    onPressed: () => _handleItemTap(item.onPressed),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 12, right: 0, top: 2, bottom: 8),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item.label,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  letterSpacing: -0.025,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              if (item.description != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  item.description!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                    letterSpacing: -0.025,
                                    color: Color(0xFF505050),
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 52,
                          height: 52,
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
                              item.iconPath,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0062FF),
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
      ),
    );
  }

  Widget _buildMenuItem(AddButtonItem item) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: -0.025,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.right,
                ),
                if (item.description != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.description!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.025,
                      color: Color(0xFF505050),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 52,
            height: 52,
            child: Center(
              child: Image.asset(
                item.iconPath,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 