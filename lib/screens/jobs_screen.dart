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
  final TextEditingController _searchController = TextEditingController();
  List<JobCard> allJobs = [
    JobCard(
      company: 'Google',
      role: 'Sr. UX Designer',
      location: 'New York',
      experience: '3 years exp.',
      salary: '\$50K/mo',
      color: const Color.fromARGB(255, 27, 38, 255),
    ),
    JobCard(
      company: 'Microsoft',
      role: 'Product Designer',
      location: 'Seattle',
      experience: '2-4 years exp.',
      salary: '\$45K/mo',
      color: const Color.fromARGB(255, 28, 212, 0),  // Microsoft blue
    ),
    JobCard(
      company: 'Apple',
      role: 'UI/UX Designer',
      location: 'California',
      experience: '4+ years exp.',
      salary: '\$55K/mo',
      color: const Color.fromARGB(255, 52, 52, 52),  // Dark gray for Apple
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
      color: const Color.fromARGB(255, 236, 212, 35),
    ),
  ];
  
  List<JobCard> filteredJobs = [];

  @override
  void initState() {
    super.initState();
    filteredJobs = List.from(allJobs);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredJobs = List.from(allJobs);
      } else {
        filteredJobs = allJobs.where((job) {
          final companyMatch = job.company.toLowerCase().contains(query);
          final roleMatch = job.role.toLowerCase().contains(query);
          final locationMatch = job.location.toLowerCase().contains(query);
          return companyMatch || roleMatch || locationMatch;
        }).toList();
      }
    });
  }

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
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A3AFF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.black,
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
                        const TextSpan(
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
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Discover'),
                    _buildDivider(),
                    _buildFilterChip('Saved'),
                    _buildDivider(),
                    _buildFilterChip('Applied'),
                    _buildDivider(),
                    _buildFilterChip('Closed'),
                    _buildDivider(),
                    _buildFilterChip('Discard'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color.fromARGB(255, 255, 255, 255), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for company or roles...',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, color: Colors.white54),
                                  onPressed: () {
                                    _searchController.clear();
                                  },
                                )
                              : null,
                        ),
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
              
              Expanded(
                child: filteredJobs.isEmpty
                    ? Center(
                        child: Text(
                          'No jobs found',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 16),
                        itemCount: filteredJobs.length,
                        itemBuilder: (context, index) => filteredJobs[index],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 9,
      width: 20,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      color: Colors.white,
      alignment: Alignment.center,
    );
  }
} 