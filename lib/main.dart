import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Card',
      home: _ProfileScreen(),
    );
  }
}

class _ProfileScreen extends StatefulWidget {
  @override
  State<_ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // backgroubd
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6D79CD), Color(0xFFAD9FF8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // aniumation in clouds
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    // Left Cloud 1 
                    top: 130 - _animation.value,
                    right: 250,
                    child: Image.asset(
                      'assets/image icons/cloud1.png',
                      width: 180,
                    ),
                  ),
                  Positioned(
                    // Right Cloud 1 
                    bottom: 620 - _animation.value,
                    left: 235,
                    child: Image.asset(
                      'assets/image icons/cloud.png',
                      width: 240,
                    ),
                  ),
                  Positioned(
                    // Right Cloud 2 
                    top: 260 - _animation.value,
                    left: 260,
                    child: Image.asset(
                      'assets/image icons/cloud1.png',
                      width: 180,
                    ),
                  ),
                  Positioned(
                    // Lefg Cloud 2
                    top: 380 - _animation.value,
                    right: 180,
                    child: Image.asset(
                      'assets/image icons/cloud.png',
                      width: 380,
                    ),
                  ),
                  Positioned(
                    // Right Cloud 3
                    top: 560 - _animation.value,
                    left: 170,
                    child: Image.asset(
                      'assets/image icons/cloud.png',
                      width: 400,
                    ),
                  ),
                ],
              );
            },
          ),
          // Profile content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/my img/myimg.png'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'DREW ALLEN RAMIREZ',
                  style: TextStyle(
                    fontFamily: 'Monstserrat',
                    fontSize: 22,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Application Developer',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xF1F2E7FD),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset('assets/image icons/fb.png'),
                      ),
                      onPressed: () {
                        _launchURL('https://www.facebook.com');
                      },
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      icon: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset('assets/image icons/insta.png'),
                      ),
                      onPressed: () {
                        _launchURL('https://instagram.com');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: socialButton(
                    '+09123456789',
                    'assets/image icons/phone1.png',
                    'sms: ', //sms number
                    'Add me to your contacts',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: socialButton(
                    '##########@gmail.com',
                    'assets/image icons/mail.png',
                    'mailto: ', //email here
                    'Send me an email',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: socialButton(
                    'GITHUB',
                    'assets/image icons/github.png',
                    'https://github.com/dawnrelle',
                    'Check my GitHub',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: socialButton(
                    'LinkedIn',
                    'assets/image icons/linkedin.png',
                    'https://www.linkedin.com',
                    'Check my LinkedIn',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget socialButton(
      String platform, String iconPath, String url, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.5),
      child: GestureDetector(
        onTap: () {
          _launchURL(url);
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6EEFF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F4D5BBB),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(iconPath, width: 40),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        platform,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 77, 91, 187),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                          color: Color.fromARGB(130, 77, 92, 187),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(
                'assets/image icons/right-arrow.png',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
