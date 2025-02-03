import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/jobs_provider.dart';
import '../../widgets/job_card.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobsProvider = Provider.of<JobsProvider>(context);
    final savedJobs = jobsProvider.savedJobs;
    
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
          child: savedJobs.isEmpty
              ? Center(
                  child: Text(
                    'No saved jobs yet',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: savedJobs.length,
                  itemBuilder: (context, index) {
                    final job = savedJobs[index];
                    return JobCard(
                      company: job.company,
                      role: job.role,
                      location: job.location,
                      experience: job.experience,
                      salary: job.salary,
                      color: job.color,
                      removeText: 'Unsave',
                      onRemove: () {
                        jobsProvider.unsaveJob(job);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Job removed from saved'),
                            backgroundColor: Colors.red,
                            action: SnackBarAction(
                              label: 'UNDO',
                              textColor: Colors.white,
                              onPressed: () {
                                jobsProvider.saveJob(job);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
} 