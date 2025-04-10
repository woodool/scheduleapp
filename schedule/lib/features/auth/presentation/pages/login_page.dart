import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // TimeHomie 로고 텍스트
            Container(
              width: 280,
              height: 34,
              alignment: Alignment.center,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Color(0xFF0062FF), Colors.white],
                  ).createShader(bounds);
                },
                child: const Text(
                  'TimeHomie',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'Daniel Black',
                    height: 50/48,
                    letterSpacing: 0.015,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // 로그인 이미지
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'assets/images/loginpage.png',
                width: 200,
                height: 200,
              ),
            ),
            // 하단 컨테이너
            Container(
              width: 374,
              height: 447,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -10),
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.06),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 안내 텍스트
                  Container(
                    width: 224,
                    height: 68,
                    alignment: Alignment.center,
                    child: const Text(
                      '자동 일정 배치로 편하게,\n모임까지 관리',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                        letterSpacing: -0.025,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 이메일 입력
                  Container(
                    width: 315,
                    height: 60,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/loginemail.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: '이메일을 입력해 주세요',
                              hintStyle: TextStyle(
                                color: Color(0xFF797979),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.025,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 비밀번호 입력
                  Container(
                    width: 315,
                    height: 60,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/loginpassword.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: '비밀번호를 입력해 주세요',
                              hintStyle: TextStyle(
                                color: Color(0xFF797979),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.025,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 로그인 버튼
                  Container(
                    width: 275,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 79, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0062FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          letterSpacing: -0.025,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  // 회원가입 링크
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        letterSpacing: -0.025,
                      ),
                      children: [
                        TextSpan(
                          text: '아이디가 없으신가요? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: '회원가입',
                          style: TextStyle(color: Color(0xFF0062FF)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 