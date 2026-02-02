import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Widgegt/HiringNavBar.dart';
import '../model/application_model.dart';
import 'package:go_roqit_app/View/Widgegt/full_screen_image_viewer.dart';

class ApplicationDetailsView extends StatelessWidget {
  const ApplicationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ApplicationModel app = Get.arguments as ApplicationModel;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 16.sp,
              color: Colors.black,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            Text(
              'Applicant Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Complete information',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Green Card
            _buildProfileCard(app),
            SizedBox(height: 16.h),

            // Applied For
            _buildWhiteCard(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.work_outline,
                      color: Colors.blue,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Applied for',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        app.role,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 12.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Applied on ${app.date}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Contact Information
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    'Contact Information',
                    Icons.person_outline,
                  ),
                  SizedBox(height: 16.h),
                  _buildContactItem(Icons.email_outlined, 'Email', app.email),
                  SizedBox(height: 16.h),
                  _buildContactItem(Icons.phone_outlined, 'Phone', app.phone),
                  SizedBox(height: 16.h),
                  _buildContactItem(
                    Icons.location_on_outlined,
                    'Location',
                    app.location,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // About
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('About', Icons.description_outlined),
                  SizedBox(height: 12.h),
                  Text(
                    app.about,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.sp,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Work Experience
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    'Work Experience',
                    Icons.work_history_outlined,
                  ),
                  SizedBox(height: 16.h),
                  // Timeline
                  ...app.workExperience.map(
                    (work) => _buildTimelineItem(
                      title: work.role,
                      subtitle: work.company,
                      date: work.dateRange,
                      location: work.location,
                      badge: work.type,
                      isLast: work == app.workExperience.last,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Education
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Education', Icons.school_outlined),
                  SizedBox(height: 16.h),
                  ...app.education.map(
                    (edu) => _buildTimelineItem(
                      title: edu.degree,
                      subtitle: edu.school,
                      date: edu.year,
                      location:
                          '', // No location for education in model currently
                      badge: '', // No badge
                      isLast: edu == app.education.last,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Skills
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    'Skills & Expertise',
                    Icons.lightbulb_outline,
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: app.skills
                        .map((skill) => _buildSkillChip(skill))
                        .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Languages
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Languages', Icons.language),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 8.w,
                    children: app.languages
                        .map((lang) => _buildLanguageChip(lang))
                        .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Portfolio
            if (app.portfolio.isNotEmpty) ...[
              _buildWhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Portfolio', Icons.link),
                    SizedBox(height: 16.h),
                    ...app.portfolio.map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: _buildPortfolioItem(item),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],

            // Salary
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    'Salary Expectations',
                    Icons.attach_money,
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA), // Light green bg
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expected Salary',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF1B5E3F),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          app.salaryExpectation,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1B5E3F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Availability
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Availability', Icons.calendar_today),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: const Color(0xFF1B5E3F),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Available to start ',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        app.availability,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: const Color(0xFF1B5E3F),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Open to work',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: const Color(0xFF1B5E3F),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Resume
            _buildWhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Resume', Icons.description),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.red,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                app.resumeObj,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Last updated: Jan 2024',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B5E3F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Additional Notes
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // Light Blue
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: const Color(0xFF2563EB),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Additional Notes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: const Color(0xFF1E40AF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    app.additionalNotes,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF1D4ED8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // Bottom Buttons
            Row(
              children: [
                // Message
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Message',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Reject
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Reject',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Shortlist
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      backgroundColor: const Color(0xFF1B5E3F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Shortlist',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: const HiringNavBar(selectedIndex: 2),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: Colors.black),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildWhiteCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildProfileCard(ApplicationModel app) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E3F),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B5E3F).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60.w,
            width: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: NetworkImage(app.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  app.role,
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Colors.orange,
                            size: 12.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            app.status,
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        app.experienceYears,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey, size: 20.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required String date,
    required String location,
    required String badge,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 2.w,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1B5E3F),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        date,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  if (badge.isNotEmpty || location.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        if (badge.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              badge,
                              style: TextStyle(
                                color: const Color(0xFF2563EB),
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        if (badge.isNotEmpty && location.isNotEmpty)
                          SizedBox(width: 8.w),
                        if (location.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              location,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F4EA),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF1B5E3F),
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildLanguageChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF2563EB),
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildPortfolioItem(PortfolioItem item) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            item.description,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth;
              const int columnCount = 3;
              final double gap = 8.w;
              final double itemSize =
                  (maxWidth - (gap * (columnCount - 1))) / columnCount;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: item.images.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String imgUrl = entry.value;
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => FullScreenImageViewer(
                          imageUrls: item.images,
                          initialIndex: index,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        imgUrl,
                        width: itemSize,
                        height: itemSize,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: itemSize,
                          height: itemSize,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.broken_image,
                            size: 20.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
