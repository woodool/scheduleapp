import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('일정 관리'),
      ),
      body: const Center(
        child: Text('일정 목록이 여기에 표시됩니다.'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (_isMenuOpen)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        print('리마인더 추가 버튼 탭됨!');
                        _toggleMenu();
                        print('메뉴 토글됨: $_isMenuOpen');
                        Navigator.pushNamed(context, '/add_reminder');
                        print('네비게이션 시도됨');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 12, right: 5, top: 8, bottom: 8),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            '리마인더 추가',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                              letterSpacing: -0.025,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFF0062FF),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/reminder.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        print('일정 추가 버튼 탭됨!');
                        _toggleMenu();
                        print('메뉴 토글됨: $_isMenuOpen');
                        Navigator.pushNamed(context, '/add_schedule');
                        print('네비게이션 시도됨');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 12, right: 5, top: 8, bottom: 8),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            '일정 추가',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                              letterSpacing: -0.025,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFF0062FF),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/schedule.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0062FF),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _toggleMenu,
                  customBorder: const CircleBorder(),
                  child: Center(
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: _isMenuOpen ? 0.125 : 0,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}