import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const GRCApp());
}

class GRCApp extends StatelessWidget {
  const GRCApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Reciprocal Colleges',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const AboutScreen(),
    const AcademicsScreen(),
    const EventsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Academics'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> imgList = [
    'https://tse3.mm.bing.net/th/id/OIP.TCDho8rcR_oDNIe7cEkcWQHaDA?rs=1&pid=ImgDetMain&o=7&rm=3',
    'https://tse3.mm.bing.net/th/id/OIP.AlyEQES3E02aqe96hk4KIAHaDG?rs=1&pid=ImgDetMain&o=7&rm=3',
    'https://tse4.mm.bing.net/th/id/OIP.2ggBhAC7c0osi7XP6TbtlwAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
  ];

  @override
  void initState() {
    super.initState();
    // 🔹 Auto-scroll every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < imgList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8F0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PageHeader(
                title: "Welcome to Global Reciprocal Colleges",
                icon: Icons.home,
                bgColor: Color(0xFFE57373),
              ),
              const SizedBox(height: 6),

              // Carousel (bigger + centered)
              SizedBox(
                height: 280, // 🔹 Increased from 220
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imgList.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95, // 🔹 Larger but still centered
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            imgList[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Image failed to load',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),

              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imgList.length,
                      (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == i ? 12 : 8,
                    height: _currentPage == i ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == i ? const Color(0xFFE57373) : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Logo Circle
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: const NetworkImage(
                  "https://tse2.mm.bing.net/th/id/OIP.elSO8H1dyWgg7yPgclyMXAAAAA?rs=1&pid=ImgDetMain&o=7&rm=3",
                ),
              ),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "TOUCHING HEARTS, RENEWING MINDS, TRANSFORMING LIVES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3E5F5),
      child: SafeArea(
        child: Column(
          children: const [
            PageHeader(
              title: "About GRC",
              icon: Icons.info,
              bgColor: Color(0xFFBA68C8),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Global Reciprocal Colleges (GRC) is an educational institution that aims to provide affordable education through a system of reciprocation, allowing students to change their lives with accessible tuition fees and scholarship grants. "
                "They offer a full range of bachelor's degree courses in various fields, including business administration and accountancy. "
                "Recently, GRC hosted a Sports Festival, showcasing the athletic abilities of students from various colleges within the organization. "
                "The college is committed to developing informed and dedicated professionals to contribute positively to society.\n\n\n\n"
                "The College of Computer Studies (CCS) offers various programs designed to prepare students for careers in Information Technology and Computing. "
                "Associate in Computer Technology: A two-year diploma program that introduces foundational knowledge in computer science and information systems, often serving as a stepping stone to a bachelors degree. "
                "Bachelor of Science in Information Technology (BSIT): A four-year program that equips students with skills to design, develop, and analyze computing systems and software.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AcademicsScreen extends StatelessWidget {
  const AcademicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8F5E9),
      child: SafeArea(
        child: Column(
          children: const [
            PageHeader(
              title: "Academics",
              icon: Icons.school,
              bgColor: Color(0xFF81C784),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Programs Offered:\n- Business Administration\n- Computer Science\n- Education\n- Hospitality Management",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD7CCC8),
      child: SafeArea(
        child: Column(
          children: const [
            PageHeader(
              title: "Events",
              icon: Icons.event,
              bgColor: Color(0xFF8D6E63),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "GRC Events Page\nComing Soon...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PageHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;

  const PageHeader({
    Key? key,
    required this.title,
    required this.icon,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: bgColor,
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
