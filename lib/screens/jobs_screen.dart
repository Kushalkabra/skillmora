import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/job_card.dart';
import '../screens/profile_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'filter_pages/saved_page.dart';
import 'filter_pages/applied_page.dart';
import 'filter_pages/closed_page.dart';
import 'package:provider/provider.dart';
import '../providers/jobs_provider.dart';
import '../models/user_data.dart';
import '../data/jobs_data.dart';
import '../models/job_model.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String? selectedFilter;
  final TextEditingController _searchController = TextEditingController();
  List<JobCard> get allJobs {
    print("Loading jobs: ${jobsData.length}");
    return jobsData.map((job) => JobCard(
      company: job.company,
      role: job.role,
      location: job.location,
      experience: job.experience,
      salary: job.salary,
      color: Color(job.color),
      postedDate: job.postedDate,
    )).toList();
  }
  
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
        filteredJobs = _getFilteredJobs();
      } else {
        final jobsToFilter = _getFilteredJobs();
        filteredJobs = jobsToFilter.where((jobCard) {
          final companyMatch = jobCard.company.toLowerCase().contains(query);
          final roleMatch = jobCard.role.toLowerCase().contains(query);
          final locationMatch = jobCard.location.toLowerCase().contains(query);
          return companyMatch || roleMatch || locationMatch;
        }).toList();
      }
    });
  }

  List<JobCard> _getFilteredJobs() {
    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
    switch (selectedFilter) {
      case 'Saved':
        return jobsProvider.savedJobs;
      case 'Applied':
        return jobsProvider.appliedJobs;
      case 'Closed':
        return []; // Add closed jobs logic if needed
      default:
        return allJobs;
    }
  }

  void _onFilterTap(String filter) {
    setState(() {
      selectedFilter = selectedFilter == filter ? null : filter;
      _onSearchChanged();
    });
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    final jobsProvider = Provider.of<JobsProvider>(context);
    
    // Get count based on filter type
    int count = 0;
    switch (label) {
      case 'Discover':
        count = jobsProvider.allJobs.length;
        break;
      case 'Saved':
        count = jobsProvider.savedJobs.length;
        break;
      case 'Applied':
        count = jobsProvider.appliedJobs.length;
        break;
      case 'Closed':
        count = 0;
        break;
    }

    return GestureDetector(
      onTap: () => _onFilterTap(label),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A3AFF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Container(
                width: 20,  // Fixed width for the count
                height: 20, // Fixed height for the count
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.1),
                  shape: BoxShape.circle,  // Make it circular
                ),
                child: Text(
                  count.toString(),
                  style: GoogleFonts.inter(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _getFilteredPage() {
    final jobsProvider = Provider.of<JobsProvider>(context);
    final query = _searchController.text.toLowerCase();
    
    switch (selectedFilter) {
      case 'Saved':
        final savedJobs = jobsProvider.savedJobs;
        final filteredSavedJobs = query.isEmpty 
            ? savedJobs 
            : savedJobs.where((jobCard) {
                final companyMatch = jobCard.company.toLowerCase().contains(query);
                final roleMatch = jobCard.role.toLowerCase().contains(query);
                final locationMatch = jobCard.location.toLowerCase().contains(query);
                return companyMatch || roleMatch || locationMatch;
              }).toList();
                
        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Saved Jobs',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: filteredSavedJobs.isEmpty
                  ? Center(
                      child: Text(
                        savedJobs.isEmpty ? 'No saved jobs yet' : 'No matching jobs found',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredSavedJobs.length,
                      itemBuilder: (context, index) {
                        final jobCard = filteredSavedJobs[index];
                        final job = JobModel(
                          company: jobCard.company,
                          role: jobCard.role,
                          location: jobCard.location,
                          experience: jobCard.experience,
                          salary: jobCard.salary,
                          color: jobCard.color.value,
                          description: '',
                          requirements: [],
                          roleDescription: '',
                          postedDate: jobCard.postedDate,
                          tags: [],
                        );
                        return Column(
                          children: [
                            JobCard(
                              company: jobCard.company,
                              role: jobCard.role,
                              location: jobCard.location,
                              experience: jobCard.experience,
                              salary: jobCard.salary,
                              color: jobCard.color,
                              postedDate: jobCard.postedDate,
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  jobsProvider.unsaveJob(job);
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Unsave',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        );

      case 'Applied':
        final appliedJobs = jobsProvider.appliedJobs;
        final filteredAppliedJobs = query.isEmpty 
            ? appliedJobs 
            : appliedJobs.where((jobCard) {
                final companyMatch = jobCard.company.toLowerCase().contains(query);
                final roleMatch = jobCard.role.toLowerCase().contains(query);
                final locationMatch = jobCard.location.toLowerCase().contains(query);
                return companyMatch || roleMatch || locationMatch;
              }).toList();

        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Applied Jobs',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: filteredAppliedJobs.isEmpty
                  ? Center(
                      child: Text(
                        appliedJobs.isEmpty ? 'No applied jobs yet' : 'No matching jobs found',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredAppliedJobs.length,
                      itemBuilder: (context, index) {
                        final jobCard = filteredAppliedJobs[index];
                        final job = JobModel(
                          company: jobCard.company,
                          role: jobCard.role,
                          location: jobCard.location,
                          experience: jobCard.experience,
                          salary: jobCard.salary,
                          color: jobCard.color.value,
                          description: '',
                          requirements: [],
                          roleDescription: '',
                          postedDate: jobCard.postedDate,
                          tags: [],
                        );
                        return Column(
                          children: [
                            JobCard(
                              company: jobCard.company,
                              role: jobCard.role,
                              location: jobCard.location,
                              experience: jobCard.experience,
                              salary: jobCard.salary,
                              color: jobCard.color,
                              postedDate: jobCard.postedDate,
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  jobsProvider.removeApplication(job);
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Remove Application',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        );

      case 'Closed':
        return const ClosedPage();
        
      default:
        return ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemCount: filteredJobs.length,
          itemBuilder: (context, index) => filteredJobs[index],
        );
    }
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
                          text: 'Hello ${UserData.userName} ',
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
                  IconButton(
                    icon: const Icon(Icons.person_outline_rounded),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
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
                child: filteredJobs.isEmpty && selectedFilter == null
                    ? Center(
                        child: Text(
                          'No jobs found',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : _getFilteredPage(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
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