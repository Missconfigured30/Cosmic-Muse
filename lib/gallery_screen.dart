import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  // Expanded list with more cosmic images (all from Unsplash - free & high quality)
  final List<Map<String, String>> cosmicImages = [
    {
      'url': 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?auto=format&fit=crop&w=800&q=80',
      'title': 'Ethereal Nebula Stream',
    },
    {
      'url': 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
      'title': 'Earth from Orbit',
    },
    {
      'url': 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?auto=format&fit=crop&w=800&q=80',
      'title': 'Blue Marble – Earth',
    },
    {
      'url': 'https://images.unsplash.com/photo-1543722530-d2c3201371e7?auto=format&fit=crop&w=800&q=80',
      'title': 'Infinite Cosmic Void',
    },
    {
      'url': 'https://images.unsplash.com/photo-1444703686981-a3abbc4d4fe3?auto=format&fit=crop&w=800&q=80',
      'title': 'Deep Space Dust',
    },
    {
      'url': 'https://media.istockphoto.com/id/1424421520/photo/northern-light-in-temiskaming-shores.jpg?s=2048x2048&w=is&k=20&c=UPmOKrxgMo2IHfzByJi9UzHQBI65hiaIHpoZYVqsFv4=',
      'title': 'Aurora Dance',
    },
    {
      'url': 'https://images.unsplash.com/photo-1515705576963-95cad62945b6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWlsa3klMjB3YXl8ZW58MHx8MHx8fDA%3D',
      'title': 'Milky Way Glow',
    },
    {
      'url': 'https://plus.unsplash.com/premium_photo-1680079229442-49a81fae2444?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8U3RhcnJ5JTIwdm9ydGV4fGVufDB8fDB8fHww',
      'title': 'Starry Vortex',
    },
    {
      'url': 'https://images.unsplash.com/photo-1614732414444-096e5f1122d5?auto=format&fit=crop&w=800&q=80',
      'title': 'Purple Nebula Dream',
    },
    {
      'url': 'https://images.unsplash.com/photo-1685776133440-437ffc5c4154?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z2FsYWN0aWMlMjBoZWFydHxlbnwwfHwwfHx8MA%3D%3D',
      'title': 'Galactic Heart',
    },
    {
      'url': 'https://images.unsplash.com/photo-1464802686167-b939a6910659?auto=format&fit=crop&w=800&q=80',
      'title': 'Cosmic Explosion',
    },
    {
      'url': 'https://media.istockphoto.com/id/519719018/photo/conceptual-universe-and-galaxies-image.webp?a=1&b=1&s=612x612&w=0&k=20&c=-fktj9KvDHuYtVWKgMhA6RcPxM6uLDJ2E1iTQh5f33w=',
      'title': 'Nebula Birth',
    },
  ];

  GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (width < 480) crossAxisCount = 1;
    if (width > 900) crossAxisCount = 3;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.cyanAccent, Colors.purpleAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Cosmic Gallery",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // 1. Immersive cosmic background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1534796636912-3b95b3ab5986?auto=format&fit=crop&w=1500&q=80',
                ),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Container(
              // Dark overlay + subtle vignette
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.4,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.85),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // 2. Gallery content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: cosmicImages.length,
                itemBuilder: (context, index) {
                  final item = cosmicImages[index];
                  return _buildCosmicCard(context, item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCosmicCard(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenViewer(
              imageUrl: item['url']!,
              title: item['title']!,
            ),
          ),
        );
      },
      child: Hero(
        tag: item['url']!,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.25),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.15),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item['url']!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator(color: Colors.cyan));
                  },
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.85),
                      ],
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Text(
                    item['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(blurRadius: 8, color: Colors.black87),
                      ],
                    ),
                    textAlign: TextAlign.center,
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


class FullScreenViewer extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FullScreenViewer({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Colors.cyanAccent),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black.withOpacity(0.7),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}