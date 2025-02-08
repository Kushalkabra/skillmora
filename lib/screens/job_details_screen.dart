import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../providers/jobs_provider.dart';
import '../widgets/job_card.dart';
import '../models/job_model.dart';

class JobDetailsScreen extends StatefulWidget {
  final String company;
  final String role;
  final String salary;
  final Color color;

  const JobDetailsScreen({
    super.key,
    required this.company,
    required this.role,
    required this.salary,
    required this.color,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  String? selectedButton;
  final String location = 'Remote';
  final String experience = '2-4 years exp.';

  @override
  void initState() {
    super.initState();
    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
    final job = JobModel(
      company: widget.company,
      role: widget.role,
      location: location,
      experience: experience,
      salary: widget.salary,
      color: widget.color.value,
      description: '',
      requirements: [],
      roleDescription: '',
      postedDate: '',
      tags: [],
    );
    if (jobsProvider.isJobApplied(job)) {
      selectedButton = 'apply';
    } else if (jobsProvider.isJobSaved(job)) {
      selectedButton = 'save';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSpotifyCard = widget.company.toLowerCase() == 'spotify';
    final Color textColor = isSpotifyCard ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Job Details',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1C1C1E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.bookmark_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: widget.color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          _buildCompanyLogo(isSpotifyCard),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.role,
                                                style: GoogleFonts.plusJakartaSans(
                                                  color: textColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                widget.company,
                                                style: GoogleFonts.plusJakartaSans(
                                                  color: textColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          _buildChip('Remote', Icons.location_on_outlined, textColor),
                                          const SizedBox(width: 8),
                                          _buildChip('Freshers', Icons.access_time, textColor),
                                          const SizedBox(width: 8),
                                          _buildChip('Fulltime', Icons.work_outline, textColor),
                                        ],
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
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time,
                                              color: Colors.black, size: 16),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Posted 2 days ago',
                                            style: GoogleFonts.plusJakartaSans(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.salary,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
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
                          const SizedBox(height: 24),
                          _buildSection(
                            'Job Description',
                            Icons.edit_note,
                            'In a UX Designer job, you\'ll need both types of skills to develop the next generation of products. You\'ll partner with Researchers and Designers to define and deliver new features.\n\nYou\'ll work closely with developers to ensure designs are implemented with quality.',
                          ),
                          const SizedBox(height: 24),
                          _buildRequirementsSection(),
                          const SizedBox(height: 24),
                          _buildSection(
                            'Your Role',
                            Icons.person_outline,
                            'As a UX Designer, you will be directly responsible for helping define and create intuitive, innovative, and delightful user experiences for our customers.',
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, String content) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              content,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.grey[400],
                height: 1.5,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline,
                    color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Skills & Requirements',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                _buildRequirement('3 years experience'),
                _buildRequirement(
                    'Degree in Computer Science, Psychology, Design or any other related fields'),
                _buildRequirement(
                    'Proficiency in User Personas, Competitive Analysis, Empathy Maps and Information Architecture'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.grey, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
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
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0),
              Colors.black.withOpacity(0.8),
              Colors.black,
            ],
            stops: const [0.0, 0.5, 0.8],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: selectedButton == 'apply'
            ? SizedBox(
                width: double.infinity,
                height: 55,
                child: GestureDetector(
                  onTap: () {
                    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
                    final job = JobModel(
                      company: widget.company,
                      role: widget.role,
                      location: location,
                      experience: experience,
                      salary: widget.salary,
                      color: widget.color.value,
                      description: '',
                      requirements: [],
                      roleDescription: '',
                      postedDate: '',
                      tags: [],
                    );

                    setState(() {
                      selectedButton = null;
                      jobsProvider.removeApplication(job);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Application removed'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 23, 46, 255),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cancel Application',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
                                final job = JobModel(
                                  company: widget.company,
                                  role: widget.role,
                                  location: location,
                                  experience: experience,
                                  salary: widget.salary,
                                  color: widget.color.value,
                                  description: '',
                                  requirements: [],
                                  roleDescription: '',
                                  postedDate: '',
                                  tags: [],
                                );

                                setState(() {
                                  if (selectedButton == 'save') {
                                    selectedButton = null;
                                    jobsProvider.unsaveJob(job);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Job removed from saved'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    selectedButton = 'save';
                                    jobsProvider.saveJob(job);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Job saved successfully!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                });
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: selectedButton == 'save' 
                                      ? const Color.fromARGB(255, 23, 46, 255) 
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        selectedButton == 'save' 
                                            ? Icons.bookmark 
                                            : Icons.bookmark_outline,
                                        color: selectedButton == 'save' ? Colors.white : Colors.black87,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        selectedButton == 'save' ? 'Unsave' : 'Save',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: selectedButton == 'save' ? Colors.white : Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 9,
                            width: 28,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            color: Colors.white,
                            alignment: Alignment.center,
                          ),
                          Expanded(
                            flex: 4,
                            child: GestureDetector(
                              onTap: () {
                                final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
                                final job = JobModel(
                                  company: widget.company,
                                  role: widget.role,
                                  location: location,
                                  experience: experience,
                                  salary: widget.salary,
                                  color: widget.color.value,
                                  description: '',
                                  requirements: [],
                                  roleDescription: '',
                                  postedDate: '',
                                  tags: [],
                                );

                                setState(() {
                                  if (selectedButton == 'apply') {
                                    selectedButton = null;
                                    jobsProvider.removeApplication(job);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Application removed'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    selectedButton = 'apply';
                                    jobsProvider.applyJob(job);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Application submitted successfully!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                });
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: selectedButton == 'apply' 
                                      ? const Color.fromARGB(255, 23, 46, 255) 
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Apply Now',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: selectedButton == 'apply' ? Colors.white : Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: selectedButton == 'apply' ? Colors.white : Colors.black87,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildCompanyLogo(bool isSpotifyCard) {
    try {
      switch (widget.company.toLowerCase()) {
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
                isSpotifyCard ? Colors.black : Colors.white,
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
                widget.company[0],
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
      }
    } catch (e) {
      print('SVG Error: $e');
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
            widget.company[0],
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
} 