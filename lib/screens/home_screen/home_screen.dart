import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({Key? key, this.userName = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
        backgroundColor: const Color(0xFF5EBBB4),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị tên người dùng
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Welcome, $userName!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Nội dung khác của màn hình HomeScreen
              const Text(
                'Your diary entries:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 16),

              // Phần hiển thị các mục nhật ký (có thể thêm sau)
              Expanded(
                child: Center(
                  child: Text(
                    'No entries yet. Start writing your diary!',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý sự kiện khi người dùng muốn thêm nhật ký mới
        },
        backgroundColor: const Color(0xFF5EBBB4),
        child: const Icon(Icons.add),
      ),
    );
  }
}
