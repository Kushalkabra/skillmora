import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/jobs_screen.dart';
import '../screens/profile_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _handleNavTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0: // Jobs
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const JobsScreen()),
        );
        break;
      case 1: // Resume
        // TODO: Navigate to Resume screen
        break;
      case 2: // Notifications
        // TODO: Navigate to Notifications screen
        break;
      case 3: // Profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index) {
    final bool isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _handleNavTap(context, index);
      },
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1, end: isSelected ? 1.2 : 1),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFCCFF00) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.work_outline, 0),
          _buildNavItem(context, Icons.edit_note, 1),
          _buildNavItem(context, Icons.notifications_outlined, 2),
          _buildNavItem(context, Icons.person_outline, 3),
        ],
      ),
    );
  }
} 