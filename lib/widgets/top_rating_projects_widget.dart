import 'package:flutter/material.dart';

class TopRatingProjectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Removing fixed height to allow container to size based on content
      // while maintaining proper constraints
      constraints: BoxConstraints(
        minHeight: 180,
        maxHeight: 220,
        maxWidth: MediaQuery.of(context).size.width - 10, // Responsive width
        minWidth: MediaQuery.of(context).size.width - 20, // Minimum width for smaller screens
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8A3EFC), Color(0xFFE068C5)], 
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allow shapes to render outside container bounds
        children: [
          // 3D Objects - positioned geometric shapes
          Positioned(
            right: -20,
            top: 10,
            child: _build3DShape('donut', 70),
          ),
          Positioned(
            right: 50,
            top: 20,
            child: _build3DShape('pyramid', 60),
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: _build3DShape('sphere', 50),
          ),
          Positioned(
            right: 100,
            bottom: 10,
            child: _build3DShape('cylinder', 60),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Prevent content overflow
              children: [
                const Text(
                  'ETHEREUM 2.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Top Rating\nProject',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.1, // Reduced line height to save space
                  ),
                ),
                const SizedBox(height: 8), // Reduced spacing
                const Text(
                  'Trending project and high rating\nProject Created by team.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.3, // Reduced line height to save space
                  ),
                ),
                const SizedBox(height: 12), // Reduced spacing
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduced padding
                    minimumSize: Size(100, 32), // Smaller minimum size
                  ),
                  child: const Text('Learn More.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to create 3D shapes
  Widget _build3DShape(String shape, double size) {
    // Using simple colored containers with different shapes
    // For a real implementation, you'd use actual 3D models or pre-rendered images
    
    switch (shape) {
      case 'donut':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: size * 0.4,
              height: size * 0.4,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: size * 0.3),
              ),
            ),
          ),
        );
      
      case 'pyramid':
        return Transform.rotate(
          angle: 0.7,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        );
      
      case 'sphere':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.teal,
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.teal.shade300, Colors.teal],
              center: Alignment.topLeft,
              focal: Alignment.center,
            ),
          ),
        );
      
      case 'cylinder':
        return Container(
          width: size * 0.6,
          height: size,
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(size * 0.3),
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
        
      default:
        return SizedBox(); // Empty fallback
    }
  }
}