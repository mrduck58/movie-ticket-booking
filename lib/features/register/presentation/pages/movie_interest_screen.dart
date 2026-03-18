import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/movie_interest_provider.dart';
import '../provider/register_provider.dart';
import '../../data/models/register_request_model.dart';

class MovieInterestScreen extends ConsumerWidget {
  const MovieInterestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interests = ref.watch(movieInterestProvider);

    const accent = Color(0xFFFF4D67);

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),

      /// APPBAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Movie Interest",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      /// BODY
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          children: [
            /// GENRE TAGS
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),

                  child: Wrap(
                    spacing: 10,
                    runSpacing: 12,

                    children: List.generate(interests.length, (index) {
                      final genre = interests[index];

                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(movieInterestProvider.notifier)
                              .toggleGenre(index);
                        },

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),

                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),

                          decoration: BoxDecoration(
                            color: genre.isSelected ? accent : Colors.white,

                            borderRadius: BorderRadius.circular(30),

                            border: Border.all(
                              color: genre.isSelected
                                  ? accent
                                  : Colors.grey.shade300,
                            ),

                            boxShadow: genre.isSelected
                                ? [
                                    const BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),

                          child: Text(
                            genre.name,
                            style: TextStyle(
                              color: genre.isSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
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
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  onPressed: () async {
                    final selected = ref
                        .read(movieInterestProvider.notifier)
                        .selectedGenres;

                    final args = GoRouterState.of(context).extra as Map;

                    final model = RegisterRequestModel(
                      email: args["email"],
                      password: args["password"],
                      phone: args["phone"],
                      fullName: args["fullName"],
                      dateOfBirth: args["dateOfBirth"],
                      favoriteGenres: selected,
                    );

                    await ref.read(registerProvider.notifier).register(model);

                    final state = ref.read(registerProvider);

                    if (state is AsyncData) {
                      context.go('/login');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Register failed")),
                      );
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
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
