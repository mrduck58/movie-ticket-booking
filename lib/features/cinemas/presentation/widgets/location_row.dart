import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class LocationRow extends StatefulWidget {
  const LocationRow({super.key});

  @override
  State<LocationRow> createState() => _LocationRowState();
}

class _LocationRowState extends State<LocationRow> {
  String location = "Hoa Lac";

  final locations = ["Hoa Lac", "Cau Giay", "My Dinh", "Dong Da", "Hoan Kiem"];

  void _pickLocation() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        String tempLocation = location;

        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// drag handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Choose location",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 16),

                  ...locations.map((e) {
                    final selected = e == tempLocation;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.pagePadding,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: selected
                          ? AppColors.primary.withOpacity(0.08)
                          : null,
                      title: Text(
                        e,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      trailing: selected
                          ? const Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                            )
                          : const Icon(Icons.radio_button_unchecked),
                      onTap: () {
                        setStateModal(() {
                          tempLocation = e;
                        });

                        //Navigator.pop(context, e);
                      },
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        location = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePadding,
        vertical: 14,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 24,
            color: AppColors.textSecondary,
          ),

          const SizedBox(width: 6),

          const Text(
            "Your location",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),

          const Spacer(),

          GestureDetector(
            onTap: _pickLocation,
            child: Row(
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 4),

                const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
