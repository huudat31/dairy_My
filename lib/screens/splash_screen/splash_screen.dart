import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_dairy/screens/home_screen/home_screen.dart';
import 'package:my_dairy/screens/splash_screen/onbroading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _checkUserName();
    // Timer để tăng thanh tiến trình
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        // Tăng giá trị tiến trình
        _progressValue += 0.2;
        if (_progressValue > 1.0) {
          _progressValue = 1.0;
        }
      });
    });

    // Chuyển màn hình sau 5 giây
    Future.delayed(const Duration(seconds: 5), () {
      // Hủy timer trước khi chuyển màn
      _timer.cancel();
      setState(() {
        _progressValue = 1.0; // Đảm bảo thanh tiến trình đầy
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnbroadingScreen()),
      );
    });
    _checkUserName();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Hàm kiểm tra tên người dùng từ SharedPreferences
  Future<void> _checkUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('user_name');

    // Thêm một chút độ trễ để hiển thị màn hình splash nếu cần
    await Future.delayed(const Duration(seconds: 1));

    if (userName != null && userName.isNotEmpty) {
      // Nếu đã có tên, chuyển thẳng đến HomeScreen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userName: userName),
          ),
        );
      }
    } else {
      // Nếu chưa có tên, chuyển đến SetNameScreen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            // Hình ảnh nhật ký
            Image.asset(
              'assets/images/splash_screen_1.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 40),
            // Tiêu đề
            const Text(
              'Daily Diary Journal with Lock',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            // Thông báo đang tải
            const Text(
              'Please wait,',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // Thanh tiến trình
            Container(
              width: 200, // Độ rộng cố định
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 200 * _progressValue,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 3),
            // Chỉ báo trang
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
