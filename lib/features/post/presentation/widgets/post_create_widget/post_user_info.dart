import 'package:flutter/material.dart';

class PostUserInfo extends StatelessWidget {
  const PostUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFF8BBD0),
            child: Text("ĐV", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 12),
          Text(
            "Nguyễn Đức Vương",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}