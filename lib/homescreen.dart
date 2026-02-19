
import 'package:cosmicmuse/PlanetBody.dart';
import 'package:cosmicmuse/WriteThoughtsBody.dart';
import 'package:cosmicmuse/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 150,

        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Padding(padding: const EdgeInsetsGeometry.only(top: 80.0),
        child: Text(
          "Cosmic Muse",
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.w900,
            fontSize: 38,
            letterSpacing: 1.8,
            shadows: [
              Shadow(
                blurRadius: 12,
                color: Colors.tealAccent,
                offset: Offset(0, 0),
              ),
              Shadow(
                blurRadius: 24,
                color: Colors.pinkAccent,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),)
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/background.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFF0A0015),
            ),
          ),


          CircularParticle(
            numberOfParticles: 80,
            speedOfParticles: 0.4,
            height: size.height,
            width: size.width,
            onTapAnimation: true,
            particleColor: Colors.white.withValues(alpha: 0.6),
            maxParticleSize: 2.8,
            isRandomColor: false,
            isRandSize: true,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.75),
                ],
              ),
            ),
          ),



          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.65),
                  Colors.black.withOpacity(0.85),
                ],
              ),
            ),
          ),


          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 24 : 40,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),


                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFFA75A1), Color(0xFF00F5D4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      "Explore the Universe",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 28 : 36,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        height: 1.15,
                        color: Colors.white, // required for shader
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Your thoughts, your cosmos",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Buttons column
                  _buildCosmicButton(
                    context,
                    label: "Explore Planets",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PlanetBody()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildCosmicButton(
                    context,
                    label: "Write Thoughts",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const WriteThoughtsBody()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildCosmicButton(
                    context,
                    label: "Image Gallery",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GalleryScreen()));
                    },
                  ),

                  const Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCosmicButton(
      BuildContext context, {
        required String label,
        required VoidCallback onPressed,
      }) {
    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return SizedBox(
      width: isSmallScreen ? null : 340,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          backgroundColor: const Color(0xFF006064).withOpacity(0.8),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0xFF00E5FF).withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: const BorderSide(
            color: const Color(0xFFAB47BC),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 21,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}