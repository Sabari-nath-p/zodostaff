import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodostaff/Screens/AuthenticationScreen/AuthenticationScreen.dart';
import 'package:zodostaff/Screens/HomeScreens/Model/UserModel.dart';

class ProfileBottomSheetContent extends StatelessWidget {
  final UserModel userProfile;

  const ProfileBottomSheetContent({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),

          // User Info Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: NetworkImage(userProfile.profilePicture!),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProfile.firstName ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userProfile.jobTitle ?? "Hospital Staff",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userProfile.email ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.shield_outlined,
                  label: 'Privacy Policy',
                  iconColor: Colors.blue.shade600,
                  onTap: () => _handlePrivacyPolicy(context),
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context,
                  icon: Icons.description_outlined,
                  label: 'Terms & Conditions',
                  iconColor: Colors.blue.shade600,
                  onTap: () => _handleTermsConditions(context),
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context,
                  icon: Icons.logout_outlined,
                  label: 'Logout',
                  iconColor: Colors.orange.shade600,
                  onTap: () => _handleLogout(context),
                ),
                const SizedBox(height: 8),
                _buildMenuItem(
                  context,
                  icon: Icons.delete_outline,
                  label: 'Delete Account',
                  iconColor: Colors.red.shade600,
                  onTap: () => _handleDeleteAccount(context),
                ),
              ],
            ),
          ),

          // Bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }

  void _handlePrivacyPolicy(BuildContext context) {
    Navigator.pop(context);
    // Navigate to privacy policy page
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening Privacy Policy...')));
  }

  void _handleTermsConditions(BuildContext context) {
    Navigator.pop(context);
    // Navigate to terms and conditions page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening Terms & Conditions...')),
    );
  }

  void _handleLogout(BuildContext context) {
    Navigator.pop(context);
    _showLogoutDialog(context);
  }

  void _handleDeleteAccount(BuildContext context) {
    Navigator.pop(context);
    _showDeleteAccountDialog(context);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                Get.offAll(() => AuthenticationScreen());
                // Perform logout logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.orange.shade600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_outlined, color: Colors.red.shade600),
              const SizedBox(width: 8),
              const Text('Delete Account'),
            ],
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Perform account deletion logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account deletion initiated...'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red.shade600),
              ),
            ),
          ],
        );
      },
    );
  }
}
