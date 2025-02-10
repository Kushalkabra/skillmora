import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/job_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobCard extends StatelessWidget {
  final String company;
  final String role;
  final String location;
  final String experience;
  final String salary;
  final Color color;
  final VoidCallback? onRemove;
  final String? removeText;
  final String postedDate;

  const JobCard({
    super.key,
    required this.company,
    required this.role,
    required this.location,
    required this.experience,
    required this.salary,
    required this.color,
    required this.postedDate,
    this.onRemove,
    this.removeText,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate if the background is light or dark
    final bool isLightColor = color.computeLuminance() > 0.5;
    final Color textColor = isLightColor ? Colors.black : Colors.white;

    final bool isSpotifyCard = company.toLowerCase() == 'spotify';

    return Column(
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: CardClipper(),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _buildCompanyLogo(isLightColor),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    role.split(' ').length > 1 
                                        ? role.split(' ').take(1).join(' ') + '\n' + role.split(' ').skip(1).join(' ')
                                        : role,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: textColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    company,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: textColor.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildChip(location, Icons.location_on_outlined, textColor),
                                const SizedBox(width: 2),
                                _buildChip(experience, Icons.school_outlined, textColor),
                                const SizedBox(width: 2),
                                _buildChip('Fulltime', Icons.access_time_outlined, textColor),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'UX Designers are the synthesis of design and development. They take Google\'s most innovative product concepts...',
                            style: GoogleFonts.plusJakartaSans(
                              color: textColor.withOpacity(0.9),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
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
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Read More',
                              style: GoogleFonts.plusJakartaSans(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: textColor.withOpacity(0.7),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Posted $postedDate',
                                style: GoogleFonts.plusJakartaSans(
                                  color: textColor.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_outlined,
                                color: Colors.black,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Posted $postedDate',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            salary,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
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
              top: 16,
              right: 16,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 27, 27, 40),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.arrow_outward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (onRemove != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRemove,
                icon: Icon(
                  removeText?.contains('Unsave') ?? false 
                      ? Icons.bookmark_remove 
                      : Icons.close,
                  size: 20,
                  color: color,
                ),
                label: Text(
                  removeText ?? 'Remove',
                  style: GoogleFonts.plusJakartaSans(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  side: BorderSide(color: color, width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCompanyLogo(bool isLightColor) {
    try {
      switch (company.toLowerCase()) {
        case 'google':
          return Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              'assets/icons/google-178-svgrepo-com.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          );
        case 'airbnb':
          return Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              'assets/icons/airbnb-179-svgrepo-com.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          );
        case 'spotify':
          return Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              'assets/icons/spotify-svgrepo-com.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isLightColor ? Colors.black : Colors.white,
                BlendMode.srcIn,
              ),
            ),
          );
        case 'microsoft':
          return Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              'assets/icons/microsoft-svgrepo-com.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          );
        case 'apple':
          return Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              'assets/icons/apple-inc-svgrepo-com.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          );
       
        default:
          return Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                company[0],
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
      }
    } catch (e, stackTrace) {
      print('SVG Error: $e');
      print('Stack trace: $stackTrace');
      return Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            company[0],
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
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
    Path path = Path();
    
    // Adjustable values
    double radius = 24;
    double cutStartX = size.width - 155;
    double cutEndX = size.width;
    double cutHeight = 75;
    
    // Start path
    path.moveTo(radius, 0);
    path.lineTo(cutStartX - 20, 0);
    
    // Initial curve and steep fall
    path.cubicTo(
      cutStartX - 10, 0,
      cutStartX + 27, cutHeight * 0.1,
      cutStartX + 26, cutHeight * 0.5,
    );

    // Continue steep fall
    path.cubicTo(
      cutStartX + 25, cutHeight * 0.7,
      cutStartX + 25, cutHeight * 0.95,
      cutStartX + 65, cutHeight * 0.98,
    );

    // Horizontal curve to edge
    path.cubicTo(
      cutStartX + 80, cutHeight * 0.98,
      cutStartX + 120, cutHeight * 0.99,
      cutEndX - 40, cutHeight * 0.99,
    );
    
    // Ultra-smooth connection to edge with gentle curve
    path.cubicTo(
      cutEndX - 25, cutHeight * 0.99,
      cutEndX - 10, cutHeight * 1.09, // Slight rise for smoothness
      cutEndX, cutHeight * 1.55, // Gentle curve up to meet the edge
    );

    // Back to normal card edge
    path.lineTo(cutEndX, size.height - radius);
    path.arcToPoint(
      Offset(cutEndX - radius, size.height),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
} 