import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:google_fonts/google_fonts.dart';
import '../screens/job_details_screen.dart';

class JobCard extends StatelessWidget {
  final String company;
  final String role;
  final String location;
  final String experience;
  final String salary;
  final Color color;

  const JobCard({
    super.key,
    required this.company,
    required this.role,
    required this.location,
    required this.experience,
    required this.salary,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CardClipper(),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: color,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: company == 'Google' ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: Center(
                                child: Text(
                                  'G',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Product Sans',
                                  ),
                                ),
                              ),
                            ) : SizedBox(
                              width: 24,
                              height: 24,
                              child: Center(
                                child: Text(
                                  company[0],
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                role,
                                style: GoogleFonts.inter(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                company,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildChip(location, Icons.location_on_outlined),
                          const SizedBox(width: 8),
                          _buildChip(experience, Icons.access_time),
                          const SizedBox(width: 8),
                          _buildChip('Fulltime', Icons.work_outline),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'UX Designers are the synthesis of design and development. They take Google\'s most innovative product concepts...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          height: 1.4,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.grey, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Posted 2 days ago',
                            style: GoogleFonts.inter(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        salary,
                        style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 9,
          right: 5,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailsScreen(
                    company: company,
                    role: role,
                    salary: salary,
                    color: color,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 24, 23, 23),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Transform.rotate(
                    angle: -pi * 0.25,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class CardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 30; // Corner radius
    double cutStartX = size.width - 90; // Where the cut starts
    double cutEndX = size.width; // Where the cut ends
    double cutHeight = 70.0; // Height of the cut
    double smoothness = 2.0; // Controls the smoothness of the curves

    Path path = Path();
    path.moveTo(radius, 0);
    path.lineTo(cutStartX, 0);

    // First curve - smooth inward bend
    path.quadraticBezierTo(
      cutStartX + smoothness, 0, // Control point
      cutStartX + smoothness, cutHeight/1.9 // End point
    );

    // Second curve - smooth outward bend to edge
    path.quadraticBezierTo(
      cutStartX + smoothness*1.9, cutHeight/1.2,
      cutEndX, cutHeight/1.32,
    );

    // Continue with rest of the card shape
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width, size.height,
      size.width - radius, size.height,
    );
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
} 