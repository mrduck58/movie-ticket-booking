import 'package:flutter/material.dart';

import 'package:movie_ticket_booking/features/account/presentation/pages/widgets/about_menu_item.dart';
class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  void _showComingSoon(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title is coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFE53935);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        surfaceTintColor: const Color(0xFFF7F7F7),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'About VNAPH Booking',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
          children: [
            Column(
              children: [
                const SizedBox(height: 8),
                Icon(Icons.local_movies, size: 64, color: red),
                const SizedBox(height: 14),
                const Text(
                  'VNAPH Booking v1.0.0',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            const SizedBox(height: 8),
            AboutMenuItem(
              title: 'Terms and Conditions',
              onTap: () => _showComingSoon(context, 'Terms and Conditions'),
            ),
            AboutMenuItem(
              title: 'Privacy Policy',
              onTap: () => _showComingSoon(context, 'Privacy Policy'),
            ),
            AboutMenuItem(
              title: 'Job Vacancy',
              onTap: () => _showComingSoon(context, 'Job Vacancy'),
            ),
            AboutMenuItem(
              title: 'Contact us',
              onTap: () => _showComingSoon(context, 'Contact us'),
            ),
            AboutMenuItem(
              title: 'Partner',
              onTap: () => _showComingSoon(context, 'Partner'),
            ),
            AboutMenuItem(
              title: 'Accessibility',
              onTap: () => _showComingSoon(context, 'Accessibility'),
            ),
            AboutMenuItem(
              title: 'Feedback',
              onTap: () => _showComingSoon(context, 'Feedback'),
            ),
            AboutMenuItem(
              title: 'Rate us',
              onTap: () => _showComingSoon(context, 'Rate us'),
            ),
            AboutMenuItem(
              title: 'Visit Our Website',
              onTap: () => _showComingSoon(context, 'Visit Our Website'),
            ),
            AboutMenuItem(
              title: 'Follow us on Social Media',
              onTap: () => _showComingSoon(context, 'Follow us on Social Media'),
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}