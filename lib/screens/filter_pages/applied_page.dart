import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/jobs_provider.dart';
import '../../widgets/job_card.dart';

class AppliedPage extends StatelessWidget {
  const AppliedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobsProvider = Provider.of<JobsProvider>(context);
    final appliedJobs = jobsProvider.appliedJobs;
    
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
          child: appliedJobs.isEmpty
              ? Center(
                  child: Text(
                    'No applied jobs yet',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: appliedJobs.length,
                  itemBuilder: (context, index) {
                    final job = appliedJobs[index];
                    return JobCard(
                      company: job.company,
                      role: job.role,
                      location: job.location,
                      experience: job.experience,
                      salary: job.salary,
                      color: job.color,
                      removeText: 'Remove Application',
                      onRemove: () {
                        jobsProvider.removeApplication(job);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Application removed'),
                            backgroundColor: Colors.red,
                            action: SnackBarAction(
                              label: 'UNDO',
                              textColor: Colors.white,
                              onPressed: () {
                                jobsProvider.applyJob(job);
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