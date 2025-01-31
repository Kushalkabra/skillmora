import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/job_card.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String? selectedFilter;

  void _onFilterTap(String filter) {
    setState(() {
      selectedFilter = selectedFilter == filter ? null : filter;
    });
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => _onFilterTap(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 33, 14, 244) : const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : const Color.fromARGB(255, 0, 0, 0),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hello Kabira ',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                        TextSpan(
                          text: '👋',
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Find Jobs text
              Text(
                'Find Jobs',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              
              // Filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      _buildFilterChip('Discover'),
                      Container(
                        width: 16,
                        height: 4,
                        color: Colors.white,
                      ),
                      _buildFilterChip('Saved'),
                      Container(
                        width: 16,
                        height: 4,
                        color: Colors.white,
                      ),
                      _buildFilterChip('Applied'),
                      Container(
                        width: 16,
                        height: 4,
                        color: Colors.white,
                      ),
                      _buildFilterChip('Closed'),
                      Container(
                        width: 16,
                        height: 4,
                        color: Colors.white,
                      ),
                      _buildFilterChip('Discar'),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Search and filter row
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for company or roles...',
                          hintStyle: GoogleFonts.inter(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.1,
                          ),
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.tune, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),
              
              // Job listings
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 16),
                  children: [
                    JobCard(
                      company: 'Google',
                      role: 'Sr. UX Designer',
                      location: 'New York',
                      experience: '3 years exp.',
                      salary: '\$50K/mo',
                      color: const Color.fromARGB(255, 27, 38, 255),
                    ),
                    JobCard(
                      company: 'Airbnb',
                      role: 'Project Manager',
                      location: 'Sydney',
                      experience: '1-5 years exp.',
                      salary: '\$25K/mo',
                      color: const Color.fromARGB(255, 253, 10, 55),
                    ),
                    JobCard(
                      company: 'Spotify',
                      role: 'Graphic Designer',
                      location: 'Remote',
                      experience: 'Entry Level',
                      salary: '\$35K/mo',
                      color: const Color.fromARGB(255, 229, 226, 58),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 