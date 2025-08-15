import 'package:flutter/material.dart';

import 'pages/decrypt-page.dart';
import 'pages/encrypt-page.dart';

void main() => runApp(EncryptionApp());

class EncryptionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '加密工具',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF2196F3), // 科技蓝主色
          brightness: Brightness.light,
          secondary: Color(0xFF64B5F6), // 辅助色
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2196F3),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    EncryptPage(),
    DecryptPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('加密工具')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: '加密',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_open),
            label: '解密',
          ),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
