import 'package:flutter/material.dart';

import '../widgets/faq_expand_tile.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedCategoryIndex = 0;
  String _keyword = '';

  final List<String> _categories = const [
    'General',
    'Account',
    'Movie',
    'Cinemas',
  ];

  final List<_FaqItem> _faqs = const [
    _FaqItem(
      category: 'General',
      question: 'What is VNAPH Booking?',
      answer:
          'VNAPH Booking is a movie ticket booking application. We offer a variety of services to create the best movie watching experience for you.',
    ),
    _FaqItem(
      category: 'General',
      question: 'How do I book tickets?',
      answer:
          'Choose a movie, select your cinema, pick a showtime, select seats, then complete payment to confirm your booking.',
    ),
    _FaqItem(
      category: 'General',
      question: 'Can I modify bookings?',
      answer:
          'At the moment, booking modifications may be limited depending on cinema policy. Please contact support or check your booking details.',
    ),
    _FaqItem(
      category: 'General',
      question: 'How to cancel or refund tickets?',
      answer:
          'Refund and cancellation policies depend on the cinema and showtime conditions. Please review the booking policy before payment.',
    ),
    _FaqItem(
      category: 'Movie',
      question: 'Can I book unreleased movies?',
      answer:
          'You can book unreleased movies once advance booking is opened by the cinema or distributor.',
    ),
    _FaqItem(
      category: 'Cinemas',
      question: 'How to report cinema issues?',
      answer:
          'You can contact support through the Help Center or use the Feedback option in the app to report cinema-related issues.',
    ),
    _FaqItem(
      category: 'Account',
      question: 'How do I change my profile information?',
      answer:
          'Go to Personal Info in the Account screen to review or update available profile details.',
    ),
    _FaqItem(
      category: 'Account',
      question: 'How do I reset my password?',
      answer:
          'Use the forgot password flow on the login screen, or contact support if you cannot access your account.',
    ),
  ];

  List<_FaqItem> get _filteredFaqs {
    final selectedCategory = _categories[_selectedCategoryIndex];

    return _faqs.where((item) {
      final matchCategory = item.category == selectedCategory;
      final matchKeyword = _keyword.trim().isEmpty ||
          item.question.toLowerCase().contains(_keyword.toLowerCase()) ||
          item.answer.toLowerCase().contains(_keyword.toLowerCase());
      return matchCategory && matchKeyword;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          'Help Center',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  final isActive = _selectedCategoryIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? red : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isActive ? red : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isActive ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _keyword = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: _filteredFaqs.isEmpty
                  ? const Center(
                      child: Text(
                        'No matching help articles',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      itemCount: _filteredFaqs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        final item = _filteredFaqs[index];
                        return FaqExpandTile(
                          question: item.question,
                          answer: item.answer,
                          initiallyExpanded: index == 0 && _keyword.isEmpty,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem {
  final String category;
  final String question;
  final String answer;

  const _FaqItem({
    required this.category,
    required this.question,
    required this.answer,
  });
}