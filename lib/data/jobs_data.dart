import '../models/job_model.dart';
import 'package:flutter/material.dart';

final List<JobModel> jobsData = [
  JobModel(
    company: 'Google',
    role: 'Sr. UX Designer',
    location: 'New York',
    experience: '3 years exp.',
    salary: '\$50K/mo',
    color: const Color.fromARGB(255, 27, 38, 255).value,
    description: 'In a UX Designer job, you\'ll need both types of skills to develop the next generation of products. You\'ll partner with Researchers and Designers to define and deliver new features.',
    requirements: [
      '3 years experience',
      'Degree in Computer Science, Psychology, Design or any other related fields',
      'Proficiency in User Personas, Competitive Analysis, Empathy Maps and Information Architecture'
    ],
    roleDescription: 'As a UX Designer, you will be directly responsible for helping define and create intuitive, innovative, and delightful user experiences for our customers.',
    postedDate: '2 days ago',
    tags: ['Remote', 'Freshers', 'Fulltime'],
  ),
  JobModel(
    company: 'Microsoft',
    role: 'Product Designer',
    location: 'Seattle',
    experience: '2-4 years exp.',
    salary: '\$45K/mo',
    color: const Color.fromARGB(255, 28, 212, 0).value,
    description: 'Join our team to shape the future of Microsoft products...',
    requirements: [
      '2-4 years experience in product design',
      'Strong portfolio showcasing end-to-end design process',
      'Experience with design systems'
    ],
    roleDescription: 'Lead product design initiatives and collaborate with cross-functional teams.',
    postedDate: '1 day ago',
    tags: ['Hybrid', 'Mid-Level', 'Fulltime'],
  ),
  JobModel(
    company: 'Apple',
    role: 'UI/UX Designer',
    location: 'California',
    experience: '4+ years exp.',
    salary: '\$55K/mo',
    color: const Color.fromARGB(255, 52, 52, 52).value,
    description: 'Join Apple to help create groundbreaking user experiences...',
    requirements: [
      '4+ years experience in UI/UX design',
      'Experience with iOS design guidelines',
      'Strong portfolio of shipped products'
    ],
    roleDescription: 'Create beautiful and intuitive interfaces for Apple products.',
    postedDate: '3 days ago',
    tags: ['Onsite', 'Senior', 'Fulltime'],
  ),
  JobModel(
    company: 'Airbnb',
    role: 'Project Manager',
    location: 'Sydney',
    experience: '1-5 years exp.',
    salary: '\$25K/mo',
    color: const Color.fromARGB(255, 253, 10, 55).value,
    description: 'Lead exciting projects at Airbnb...',
    requirements: [
      'Project management certification',
      'Experience with Agile methodologies',
      'Strong communication skills'
    ],
    roleDescription: 'Manage and deliver key projects for Airbnb platform.',
    postedDate: '5 days ago',
    tags: ['Remote', 'Mid-Level', 'Fulltime'],
  ),
  JobModel(
    company: 'Spotify',
    role: 'Graphic Designer',
    location: 'Remote',
    experience: 'Entry Level',
    salary: '\$35K/mo',
    color: const Color.fromARGB(255, 236, 212, 35).value,
    description: 'Create engaging visual content for Spotify...',
    requirements: [
      'Design degree or equivalent experience',
      'Proficiency in Adobe Creative Suite',
      'Strong visual design skills'
    ],
    roleDescription: 'Design creative assets for Spotify marketing campaigns.',
    postedDate: '1 week ago',
    tags: ['Remote', 'Junior', 'Fulltime'],
  ),
  JobModel(
    company: 'Amazon',
    role: 'Software Developer',
    location: 'Remote',
    experience: 'Entry Level',
    salary: '\$135K/mo',
    color: const Color.fromARGB(255, 166, 35, 236).value,
    description: 'Join Amazon as a Software Developer to build scalable solutions...',
    requirements: [
      'Bachelor\'s degree in Computer Science or related field',
      'Knowledge of data structures and algorithms',
      'Experience with one or more programming languages'
    ],
    roleDescription: 'Build and maintain scalable software solutions for Amazon\'s platforms.',
    postedDate: '1 week ago',
    tags: ['Remote', 'Entry Level', 'Fulltime'],
  ), JobModel(
    company: 'Samsung',
    role: 'Devops Engineer',
    location: 'Remote',
    experience: 'Entry Level',
    salary: '\$165K/mo',
    color: const Color.fromARGB(255, 16, 238, 216).value,
    description: 'Join Samsung as a Devops Engineer to build scalable solutions...',
    requirements: [
      'Bachelor\'s degree in Computer Science or related field',
      'Knowledge of data structures and algorithms',
      'Experience with one or more programming languages'
    ],
    roleDescription: 'Build and maintain scalable software solutions for Samsung\'s platforms.',
    postedDate: '1 week ago',
    tags: ['Remote', 'Entry Level', 'Fulltime'],
  ),
  // Add more jobs here...
]; 