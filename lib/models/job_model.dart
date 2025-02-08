class JobModel {
  final String company;
  final String role;
  final String location;
  final String experience;
  final String salary;
  final int color;
  final String description;
  final List<String> requirements;
  final String roleDescription;
  final String postedDate;
  final List<String> tags;

  JobModel({
    required this.company,
    required this.role,
    required this.location,
    required this.experience,
    required this.salary,
    required this.color,
    required this.description,
    required this.requirements,
    required this.roleDescription,
    required this.postedDate,
    required this.tags,
  });
} 