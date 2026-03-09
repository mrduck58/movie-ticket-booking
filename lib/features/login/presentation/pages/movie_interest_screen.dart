import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../provider/movie_interest_provider.dart';

class MovieInterestScreen extends ConsumerWidget {
  const MovieInterestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interests = ref.watch(movieInterestProvider);

    const accent = Color(0xFFFF4D67);

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text(
          "Movie Interest",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          children: [
            /// GENRE GRID
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: interests.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 3.5,
                ),

                itemBuilder: (context, index) {
                  final genre = interests[index];

                  return GestureDetector(
                    onTap: () {
                      ref
                          .read(movieInterestProvider.notifier)
                          .toggleGenre(index);
                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),

                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: genre.isSelected ? accent : Colors.white,

                        borderRadius: BorderRadius.circular(30),

                        border: Border.all(
                          color: genre.isSelected
                              ? accent
                              : Colors.grey.shade400,
                        ),

                        boxShadow: [
                          if (genre.isSelected)
                            const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                        ],
                      ),

                      child: Text(
                        genre.name,
                        style: TextStyle(
                          color: genre.isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            /// SAVE BUTTON
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  onPressed: () {
                    final selected = ref
                        .read(movieInterestProvider.notifier)
                        .selectedGenres;

                    debugPrint("Selected genres: $selected");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },

                  child: const Text("Save", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
