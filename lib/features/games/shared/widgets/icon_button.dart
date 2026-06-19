

import 'package:flutter/material.dart';

class ShellIconBtn extends StatelessWidget {
  final IconData icon;
  final double   size, iconSz;
  final Color    color;
  final VoidCallback onTap;

  const ShellIconBtn({super.key, 
    required this.icon,
    required this.size,
    required this.iconSz,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:  size,
        height: size,
        decoration: BoxDecoration(
          color:  color.withOpacity(0.12),
          shape:  BoxShape.circle,
        ),
        child: Icon(icon, size: iconSz, color: color),
      ),
    );
  }
}