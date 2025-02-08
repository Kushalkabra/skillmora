import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../data/jobs_data.dart';
import '../widgets/job_card.dart';

class JobsProvider extends ChangeNotifier {
  final List<JobModel> _allJobs = jobsData;
  final List<JobModel> _savedJobs = [];
  final List<JobModel> _appliedJobs = [];

  List<JobModel> get allJobs => _allJobs;
  List<JobCard> get savedJobs {
    return _savedJobs.map((job) => JobCard(
      company: job.company,
      role: job.role,
      location: job.location,
      experience: job.experience,
      salary: job.salary,
      color: Color(job.color),
      postedDate: job.postedDate,
      removeText: 'Unsave',
      onRemove: () => unsaveJob(job),
    )).toList();
  }
  List<JobCard> get appliedJobs {
    return _appliedJobs.map((job) => JobCard(
      company: job.company,
      role: job.role,
      location: job.location,
      experience: job.experience,
      salary: job.salary,
      color: Color(job.color),
      postedDate: job.postedDate,
      removeText: 'Remove Application',
      onRemove: () => removeApplication(job),
    )).toList();
  }

  void saveJob(JobModel job) {
    if (!_savedJobs.contains(job)) {
      _savedJobs.add(job);
      notifyListeners();
    }
  }

  void unsaveJob(JobModel job) {
    _savedJobs.removeWhere((savedJob) => 
      savedJob.company == job.company && 
      savedJob.role == job.role
    );
    notifyListeners();
  }

  void applyJob(JobModel job) {
    if (!_appliedJobs.contains(job)) {
      _appliedJobs.add(job);
      notifyListeners();
    }
  }

  void removeApplication(JobModel job) {
    _appliedJobs.removeWhere((appliedJob) => 
      appliedJob.company == job.company && 
      appliedJob.role == job.role
    );
    notifyListeners();
  }

  bool isJobSaved(JobModel job) {
    return _savedJobs.any((savedJob) => 
      savedJob.company == job.company && 
      savedJob.role == job.role
    );
  }

  bool isJobApplied(JobModel job) {
    return _appliedJobs.any((appliedJob) => 
      appliedJob.company == job.company && 
      appliedJob.role == job.role
    );
  }

  List<JobModel> searchJobs(String query) {
    query = query.toLowerCase();
    return _allJobs.where((job) {
      final companyMatch = job.company.toLowerCase().contains(query);
      final roleMatch = job.role.toLowerCase().contains(query);
      final locationMatch = job.location.toLowerCase().contains(query);
      return companyMatch || roleMatch || locationMatch;
    }).toList();
  }

  int get totalJobs => _allJobs.length;
  int get savedJobsCount => _savedJobs.length;
  int get appliedJobsCount => _appliedJobs.length;
  
  int getCountByStatus(String status) {
    switch (status) {
      case 'Discover':
        return totalJobs;
      case 'Saved':
        return savedJobsCount;
      case 'Applied':
        return appliedJobsCount;
      case 'Closed':
        return 0;
      default:
        return 0;
    }
  }
} 