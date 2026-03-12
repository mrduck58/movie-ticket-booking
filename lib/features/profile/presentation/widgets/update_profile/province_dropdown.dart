import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/profile/data/datasources/province_service.dart';
import 'package:movie_ticket_booking/features/profile/data/models/province_model.dart';

class ProvinceDropdown extends StatefulWidget {
  final String label;
  final String? value;
  final Function(String) onChanged;

  const ProvinceDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<ProvinceDropdown> createState() => _ProvinceDropdownState();
}

class _ProvinceDropdownState extends State<ProvinceDropdown> {

  final service = ProvinceService();

  List<Province> provinces = [];
  String? selectedProvince;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProvinces();
  }

  void loadProvinces() async {

    final data = await service.fetchProvinces();

    setState(() {
      provinces = data;

      // nếu profile đã có tỉnh -> set làm giá trị mặc định
      if (widget.value != null &&
          provinces.any((p) => p.name == widget.value)) {
        selectedProvince = widget.value;
      }

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const CircularProgressIndicator();
    }

    return DropdownButtonFormField<String>(
      initialValue: provinces.any((p) => p.name == widget.value) ? widget.value : null,

      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),

      items: provinces.map((province) {
        return DropdownMenuItem(
          value: province.name,
          child: Text(province.name),
        );
      }).toList(),

      onChanged: (value) {
        widget.onChanged(value!);
      },
    );
  }
}
