
import 'package:flutter/material.dart';

class PlanetBody extends StatelessWidget {
  const PlanetBody({super.key});

  final List<Map<String, String>> planets = const [
    {
      'name': 'Mercury',
      'facts':
          'The smallest planet in our solar system and the closest to the Sun. Mercury experiences extreme temperature fluctuations, ranging from about 430°C (800°F) during the day to -180°C (-290°F) at night due to its lack of a significant atmosphere. A year on Mercury lasts just 88 Earth days, while one full rotation takes about 59 Earth days. Its surface is heavily cratered, similar to Earth’s Moon.',
      'image':
          'https://images.unsplash.com/photo-1771443437559-02fc5290d5d2?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Venus',
      'facts':
          'Often called Earth’s twin because of its similar size and structure, Venus has a thick atmosphere composed mainly of carbon dioxide with clouds of sulfuric acid. This creates a runaway greenhouse effect, making it the hottest planet in the solar system with surface temperatures around 465°C (869°F). Venus rotates in the opposite direction of most planets (retrograde rotation), meaning the Sun rises in the west and sets in the east.',
      'image':
          'https://images.unsplash.com/photo-1639393455114-84df73f758cd?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Earth',
      'facts':
          'Our home planet and the only known world to support life. About 71% of Earth’s surface is covered by water, including oceans, lakes, and rivers. It has a nitrogen-oxygen rich atmosphere that protects life and regulates temperature. Earth’s magnetic field shields it from harmful solar radiation, and its single natural satellite, the Moon, influences tides and helps stabilize the planet’s axial tilt and climate.',
      'image':
          'https://images.unsplash.com/photo-1639653279211-09958a51fb00?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Mars',
      'facts':
          'Known as the Red Planet due to iron oxide (rust) on its surface, Mars has the largest volcano in the solar system, Olympus Mons, and a massive canyon system called Valles Marineris. Evidence suggests that liquid water once flowed on its surface. Mars has a thin carbon dioxide atmosphere and experiences dust storms that can cover the entire planet. It has two small moons, Phobos and Deimos.',
      'image':
          'https://images.unsplash.com/photo-1639477735279-c36dda1f7ebb?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Jupiter',
      'facts':
          'The largest planet in the solar system, Jupiter is a gas giant primarily composed of hydrogen and helium. It is famous for the Great Red Spot, a massive storm that has been raging for over 300 years. Jupiter has a strong magnetic field and more than 79 known moons, including the four largest: Io, Europa, Ganymede, and Callisto. Its immense gravity helps protect inner planets by attracting comets and asteroids.',
      'image':
          'https://images.unsplash.com/photo-1639477734993-44982980229e?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Saturn',
      'facts':
          'Saturn is a gas giant best known for its spectacular ring system made of ice and rock particles. It is the second-largest planet in the solar system and is composed mainly of hydrogen and helium. Saturn has over 80 known moons, including Titan, which has a thick atmosphere and lakes of liquid methane. Unique hexagonal storm patterns have been observed at its north pole.',
      'image':
          'https://images.unsplash.com/photo-1639548206755-b20081a7cadc?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Uranus',
      'facts':
          'An ice giant with a unique tilt of about 98 degrees, Uranus essentially rotates on its side, causing extreme seasonal variations. It has a pale blue color due to methane in its atmosphere, which absorbs red light. Uranus has faint rings and at least 27 known moons. It is one of the coldest planets in the solar system, with temperatures dropping below -220°C (-364°F).',
      'image':
          'https://images.unsplash.com/photo-1639548206689-1a5238f8d5bb?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'name': 'Neptune',
      'facts':
          'The farthest known planet from the Sun, Neptune is an ice giant known for its deep blue color and extremely strong supersonic winds, the fastest in the solar system. It has a dynamic atmosphere with large storm systems such as the Great Dark Spot. Neptune has 14 known moons, including Triton, which orbits in the opposite direction of the planet’s rotation and is believed to be a captured object from the Kuiper Belt.',
      'image':
          'https://images.unsplash.com/photo-1639477878754-4119b60fb02a?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8fDB8fHx8fA%3D%3D',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: planets.length,
      itemBuilder: (context, index) {
        final planet = planets[index];
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(milliseconds: 500 + index * 100),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Card(
            color: const Color(0xFF1E1E2C),
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: planet['image']!,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      planet['image']!,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        planet['name']!,
                        style: const TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        planet['facts']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
