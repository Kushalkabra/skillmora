import 'package:flutter/material.dart';
import '../widgets/job_card.dart';

class JobsProvider extends ChangeNotifier {
  final List<JobCard> _savedJobs = [];
  final List<JobCard> _appliedJobs = [];

  List<JobCard> get savedJobs => _savedJobs;
  List<JobCard> get appliedJobs => _appliedJobs;

  void saveJob(JobCard job) {
    if (!_savedJobs.contains(job)) {
      _savedJobs.add(job);
      notifyListeners();
    }
  }

  void unsaveJob(JobCard job) {
    _savedJobs.removeWhere((savedJob) => 
      savedJob.company == job.company && 
      savedJob.role == job.role
    );
    notifyListeners();
  }

  void applyJob(JobCard job) {
    if (!_appliedJobs.contains(job)) {
      _appliedJobs.add(job);
      notifyListeners();
    }
  }

  void removeApplication(JobCard job) {
    _appliedJobs.removeWhere((appliedJob) => 
      appliedJob.company == job.company && 
      appliedJob.role == job.role
    );
    notifyListeners();
  }

  bool isJobSaved(JobCard job) {
    return _savedJobs.any((savedJob) => 
      savedJob.company == job.company && 
      savedJob.role == job.role
    );
  }

  bool isJobApplied(JobCard job) {
    return _appliedJobs.any((appliedJob) => 
      appliedJob.company == job.company && 
      appliedJob.role == job.role
    );
  }
} 