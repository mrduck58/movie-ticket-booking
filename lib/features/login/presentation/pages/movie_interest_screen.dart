import 'package:flutter/material.dart';
import 'complete_profile.dart';
class MovieInterestScreen extends StatefulWidget {
  const MovieInterestScreen({super.key});

  @override
  State<MovieInterestScreen> createState() =>
      _MovieInterestScreenState();
}

class _MovieInterestScreenState
    extends State<MovieInterestScreen> {

  final List<String> genres = [
    "Action",
    "Adventure",
    "Comedy",
    "Drama",
    "Romance",
    "Fantasy",
    "Science Fiction",
    "Thriller",
    "War",
    "Family",
    "Spy",
    "Travel",
  ];

  final Set<String> selectedGenres = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Back
              IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CompleteProfileScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),


              const Center(
                child: Text(
                  "Movie Interest",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Genre Chips
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: genres.map((genre) {
                  final isSelected =
                      selectedGenres.contains(genre);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedGenres.remove(genre);
                        } else {
                          selectedGenres.add(genre);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFF5A5F)
                            : Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFFF5A5F)
                              : Colors.grey,
                        ),
                      ),
                      child: Text(
                        genre,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              /// Save Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFFF5A5F),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Sau này chuyển sang Home
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}