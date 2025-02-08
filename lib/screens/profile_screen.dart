import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'jobs_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/user_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> _proficiencyLevels = ['Beginner', 'Intermediate', 'Expert'];

  void _updateContent(String section, dynamic newContent) {
    setState(() {
      switch (section) {
        case 'About':
          UserData.aboutText = newContent as String;
          break;
        case 'Career Preferences':
          UserData.careerPreferences = (newContent as List<Map<String, String>>);
          break;
        case 'Skills':
          UserData.skills = (newContent as List<String>);
          break;
        case 'Languages Known':
          UserData.languages = List<Map<String, String>>.from(newContent);
          break;
      }
    });
  }

  void _handleNavTap(BuildContext context, int index) {
    switch (index) {
      case 0: // Jobs
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const JobsScreen()),
        );
        break;
      case 1: // Resume
        // TODO: Navigate to Resume screen
        break;
      case 2: // History
        // TODO: Navigate to History screen
        break;
      case 3: // Profile
        // Already on profile
        break;
    }
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index) {
    final bool isSelected = index == 3;
    
    return GestureDetector(
      onTap: () {
        // Add haptic feedback for better touch experience
        HapticFeedback.lightImpact();
        _handleNavTap(context, index);
      },
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1, end: isSelected ? 1.2 : 1),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFCCFF00) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
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
                    'Profile',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Section with Neon Background
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCFF00),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                UserData.userName,
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onPressed: () {
                                  _showNameEditDialog(context);
                                },
                              ),
                            ],
                          ),
                          Text(
                            'Software Developer',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Download Resume',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(0xFFCCFF00),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.download_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Main Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: _buildSection(
                              context,
                              'About',
                              UserData.aboutText,
                              showMore: true,
                            ),
                          ),
                          _buildNeonDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: _buildSection(
                              context,
                              'Career Preferences',
                              null,
                              items: UserData.careerPreferences.map((pref) => 
                                _buildPreferenceItem(pref.keys.first, pref.values.first)
                              ).toList(),
                            ),
                          ),
                          _buildNeonDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: _buildSection(
                              context,
                              'Skills',
                              null,
                              chips: UserData.skills,
                            ),
                          ),
                          _buildNeonDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: _buildSection(
                              context,
                              'Languages Known',
                              null,
                              items: UserData.languages.map((lang) => 
                                _buildLanguageItem(lang.keys.first, lang.values.first)
                              ).toList(),
                            ),
                          ),
                          // Add bottom padding for scrolling
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildSection(BuildContext context, String title, String? content, {
    bool showMore = false,
    List<Widget>? items,
    List<String>? chips,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFCCFF00),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                _showEditDialog(context, title, content, items, chips);
              },
              child: Icon(
                Icons.edit_outlined,
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                size: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (content != null) ...[
          Text(
            content,
            style: GoogleFonts.plusJakartaSans(
              color: const Color.fromARGB(255, 255, 255, 255),
              height: 1.5,
            ),
          ),
          if (showMore)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'See more',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color.fromARGB(121, 255, 255, 255),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
        ],
        if (items != null) ...[
          const SizedBox(height: 8),
          ...items,
        ],
        if (chips != null) ...[
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips.map((chip) => _buildChip(chip)).toList(),
          ),
        ],
      ],
    );
  }

  void _showEditDialog(BuildContext context, String title, String? content, List<Widget>? items, List<String>? chips) {
    final TextEditingController textController = TextEditingController(text: content);
    final List<TextEditingController> itemControllers = [];
    
    // Initialize controllers for items if they exist
    if (title == 'Career Preferences') {
      for (var pref in UserData.careerPreferences) {
        itemControllers.add(TextEditingController(text: pref.values.first));
      }
    } else if (title == 'Languages Known') {
      for (var lang in UserData.languages) {
        String initialValue = lang.values.first;
        if (!_proficiencyLevels.contains(initialValue)) {
          initialValue = _proficiencyLevels[0];
        }
        itemControllers.add(TextEditingController(text: initialValue));
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit $title',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (content != null)
                    TextField(
                      controller: textController,
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter your $title',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  if (title == 'Career Preferences' || title == 'Languages Known')
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemControllers.length,
                      itemBuilder: (context, index) {
                        final label = title == 'Career Preferences' 
                            ? UserData.careerPreferences[index].keys.first
                            : UserData.languages[index].keys.first;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: title == 'Languages Known'
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        label,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.white24,
                                            width: 1,
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: itemControllers[index].text,
                                            dropdownColor: const Color(0xFF1C1C1E),
                                            style: GoogleFonts.plusJakartaSans(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                            ),
                                            isExpanded: true,
                                            items: _proficiencyLevels.map((String level) {
                                              return DropdownMenuItem<String>(
                                                value: level,
                                                child: Text(
                                                  level,
                                                  style: GoogleFonts.plusJakartaSans(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                setState(() {
                                                  itemControllers[index].text = newValue;
                                                  // Update the languages list immediately
                                                  final newLangs = List<Map<String, String>>.from(UserData.languages);
                                                  newLangs[index] = {UserData.languages[index].keys.first: newValue};
                                                  _updateContent('Languages Known', newLangs);
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : TextField(
                                  controller: itemControllers[index],
                                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: label,
                                    labelStyle: GoogleFonts.plusJakartaSans(
                                      color: Colors.white70,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  if (title == 'Skills')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: UserData.skills.map((skill) {
                            return Chip(
                              label: Text(skill),
                              deleteIcon: const Icon(Icons.close, size: 16),
                              onDeleted: () {
                                setState(() {
                                  UserData.skills.remove(skill);
                                });
                                Navigator.pop(context);
                                _showEditDialog(context, title, content, items, UserData.skills);
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Add new skill',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                final newSkill = textController.text.trim();
                                if (newSkill.isNotEmpty) {
                                  setState(() {
                                    UserData.skills.add(newSkill);
                                  });
                                  textController.clear();
                                  Navigator.pop(context);
                                  _showEditDialog(context, title, content, items, UserData.skills);
                                }
                              },
                            ),
                          ),
                          controller: textController,
                          style: GoogleFonts.plusJakartaSans(color: Colors.white),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Save changes based on section
                          switch (title) {
                            case 'About':
                              _updateContent(title, textController.text);
                              break;
                            case 'Career Preferences':
                              final newPrefs = List<Map<String, String>>.generate(
                                UserData.careerPreferences.length,
                                (index) => {
                                  UserData.careerPreferences[index].keys.first: 
                                  itemControllers[index].text
                                },
                              );
                              _updateContent(title, newPrefs);
                              break;
                            case 'Languages Known':
                              final newLangs = List<Map<String, String>>.generate(
                                UserData.languages.length,
                                (index) => {
                                  UserData.languages[index].keys.first: 
                                  itemControllers[index].text
                                },
                              );
                              _updateContent(title, newLangs);
                              break;
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCCFF00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showNameEditDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: UserData.userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Edit Name',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: TextField(
          controller: nameController,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter your name',
            hintStyle: GoogleFonts.plusJakartaSans(
              color: Colors.white54,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCCFF00)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                UserData.userName = nameController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCCFF00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Save',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(String language, String level) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            language,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
            ),
          ),
          Text(
            level,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNeonDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
     
      child: Container(
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFFCCFF00),  // Solid neon color
        ),
      ),
    );
  }
} 