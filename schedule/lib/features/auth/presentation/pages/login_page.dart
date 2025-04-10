import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                // TimeHomie 로고 텍스트
                Container(
                  width: 280,
                  height: 80,
                  alignment: Alignment.center,
                  child: Text(
                    'TimeHomie',
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'DanielBlack',
                      height: 1.2,
                      letterSpacing: 0.015,
                      color: Color(0xFF0062FF),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                // 로그인 이미지
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Image.asset(
                    'assets/images/loginpage.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                // 하단 컨테이너
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 480,
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
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 28, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 안내 텍스트
                          Container(
                            width: 315,
                            height: 80,
                            alignment: Alignment.center,
                            child: const Text(
                              '자동 일정 배치로 편하게\n모임까지 관리',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                letterSpacing: -0.025,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          // 이메일 입력
                          Container(
                            width: 315,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: const Color(0xFF0062FF)),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Image.asset(
                                    'assets/images/loginemail.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: TextFormField(
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
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                      letterSpacing: -0.025,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: const Color(0xFF0062FF)),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Image.asset(
                                    'assets/images/loginpassword.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: TextFormField(
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
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                      letterSpacing: -0.025,
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
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
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
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 