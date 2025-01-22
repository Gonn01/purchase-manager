import 'package:flutter/material.dart';

/// {@template LDBottomNavigationBarItem}
/// Item for the bottom navigation bar
/// {@endtemplate}
class LDBottomNavigationBarItem extends StatelessWidget {
  /// {@macro LDBottomNavigationBarItem}
  const LDBottomNavigationBarItem({
    required this.isSelected,
    required this.value,
    required this.onTap,
    required this.text,
    this.icon,
    this.image,
    super.key,
  });

  /// If the item is selected
  final bool isSelected;

  /// The value of the item
  final int value;

  /// The text of the item
  final String text;

  /// The icon of the item
  final IconData? icon;

  /// The profile picture of the item
  final Widget? image;

  /// Function to call when the item is tapped
  // ignore: avoid_positional_boolean_parameters
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    const divider = 2;

    final width = MediaQuery.of(context).size.width / divider;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: isSelected
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff00B3A3),
                      )
                    : null,
                child: image ??
                    Icon(
                      icon,
                      size: 30,
                      color:
                          isSelected ? Colors.white : const Color(0xff00B3A3),
                    ),
              ),
              Text(
                text,
                style: TextStyle(
                  color:
                      isSelected ? Colors.transparent : const Color(0xff00B3A3),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
