import 'package:adstacks/widgets/all_projects_widget.dart';
import 'package:adstacks/widgets/aniversary_widget.dart';
import 'package:adstacks/widgets/birthday_card_widget.dart';
import 'package:adstacks/widgets/calander_widget.dart';
import 'package:adstacks/widgets/perfomance_chart_widget.dart';
import 'package:adstacks/widgets/sidebar_widget.dart';
import 'package:adstacks/widgets/top_creators_widget.dart';
import 'package:adstacks/widgets/top_nav_bar_widget.dart';
import 'package:adstacks/widgets/top_rating_projects_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Drawer controller for mobile view
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    // Get screen width to determine layout
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Define breakpoints
    const mobileBreakpoint = 600;
    const tabletBreakpoint = 1024;
    
    // Determine current device type
    final isMobile = screenWidth < mobileBreakpoint;
    final isTablet = screenWidth >= mobileBreakpoint && screenWidth < tabletBreakpoint;
    final isDesktop = screenWidth >= tabletBreakpoint;
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      
      // Show app bar only on mobile and tablet
      appBar: (isMobile || isTablet) 
        ? AppBar(
            title: const Text('Dashboard'),
            elevation: 0,
            // Show menu button only on mobile
            leading: isMobile ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ) : null,
          ) 
        : null,
      
      // Drawer for mobile view
      drawer: isMobile ? Drawer(
        child: SidebarWidget(isCompact: true),
      ) : null,
      
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left sidebar - visible on tablet and desktop only
          if (!isMobile)
            SidebarWidget(isCompact: isTablet),
          
          // Main content area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top navigation bar - visible only on desktop
                if (isDesktop) TopNavBarWidget(),
                
                // Main dashboard content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
                    child: _buildDashboardContent(context, isMobile, isTablet),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDashboardContent(BuildContext context, bool isMobile, bool isTablet) {
    // If mobile, stack all widgets vertically
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopRatingProjectWidget(),
          const SizedBox(height: 16),
          AllProjectsWidget(),
          const SizedBox(height: 16),
          TopCreatorsWidget(),
          const SizedBox(height: 16),
          PerformanceChartWidget(),
          const SizedBox(height: 16),
          CalendarWidget(),
          const SizedBox(height: 16),
          BirthdayWidget(),
          const SizedBox(height: 16),
          AnniversaryWidget(),
        ],
      );
    }
    
    // For tablet, use a different layout with adjusted flex ratios
    if (isTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopRatingProjectWidget(),
          const SizedBox(height: 16),
          
          // Projects and creators row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: AllProjectsWidget()),
              const SizedBox(width: 16),
              Expanded(child: TopCreatorsWidget()),
            ],
          ),
          const SizedBox(height: 16),
          
          PerformanceChartWidget(),
          const SizedBox(height: 16),
          
          // Calendar and events section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: CalendarWidget()),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    BirthdayWidget(),
                    const SizedBox(height: 16),
                    AnniversaryWidget(),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
    
    // For desktop, use the original layout with some adjustments
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left and middle column (70%)
        Expanded(
          flex: 7,
          child: Column(
            children: [
              // Featured project card
              TopRatingProjectWidget(),
              const SizedBox(height: 16),
              
              // Projects and creators row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // All projects card
                  Expanded(child: AllProjectsWidget()),
                  const SizedBox(width: 16),
                  
                  // Top creators card
                  Expanded(child: TopCreatorsWidget()),
                ],
              ),
              const SizedBox(height: 16),
              
              // Performance chart
              PerformanceChartWidget(),
            ],
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Right column - Calendar and events (30%)
        Expanded(
          flex: 3,
          child: Column(
            children: [
              // Calendar widget
              CalendarWidget(),
              const SizedBox(height: 16),
              
              // Birthday section
              BirthdayWidget(),
              const SizedBox(height: 16),
              
              // Anniversary section
              AnniversaryWidget(),
            ],
          ),
        ),
      ],
    );
  }
}