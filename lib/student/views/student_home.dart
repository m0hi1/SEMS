import 'package:sems/shared/utils/snacbar_helper.dart';
import 'package:sems/shared/widget/header_crousel.dart';
import 'package:sems/student/utils/student_drawer.dart';
import 'package:sems/student/utils/student_grid_section.dart';
import 'package:sems/student/utils/student_section_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router.dart';
import '../../shared/utils/cutom_appbar.dart';
import '../../shared/utils/grid_icon_data.dart';
import '../../shared/widget/grid_button_widget.dart';
import '../../shared/widget/my_app_bar.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'SEMS ACE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 36, 173, 242),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              context.push(AppRoute.notifications.path);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              SnackbarHelper.showInfoSnackBar(context, 'Under Development');
            },
          ),
        ],
      ),
      drawer: const StudentDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomCarousel(
                imageUrls: [
                  "https://picsum.photos/id/1/200/300",
                  "https://picsum.photos/id/2/200/300",
                  "https://picsum.photos/id/3/200/300",
                  "https://picsum.photos/id/4/200/300",
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const StudentSectionCard(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Quick Access',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const StudentGridSection(),
              const SizedBox(height: 8),
              // Recent Activities Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recent Activities',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildActivityItem(
                          'New Assignment Posted',
                          'Mathematics - Due Tomorrow',
                          Icons.assignment,
                        ),
                        _buildActivityItem(
                          'Test Result Available',
                          'Physics Mid-term',
                          Icons.equalizer,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // New Section: Upcoming Events
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upcoming Events',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildEventItem(
                          'Science Fair',
                          'December 20, 2024',
                          Icons.event,
                        ),
                        _buildEventItem(
                          'Parent-Teacher Meeting',
                          'January 15, 2025',
                          Icons.people,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.chat),
        onPressed: () {
          context.push(AppRoute.semsAiAssistant.path);
        },
        label: const Text('SEMS AI'),
        backgroundColor: const Color.fromARGB(255, 36, 173, 242),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem(String title, String date, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
