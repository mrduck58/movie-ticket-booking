import 'package:flutter/material.dart';

class FaqExpandTile extends StatefulWidget {
  final String question;
  final String answer;
  final bool initiallyExpanded;

  const FaqExpandTile({
    super.key,
    required this.question,
    required this.answer,
    this.initiallyExpanded = false,
  });

  @override
  State<FaqExpandTile> createState() => _FaqExpandTileState();
}

class _FaqExpandTileState extends State<FaqExpandTile> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.answer,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}