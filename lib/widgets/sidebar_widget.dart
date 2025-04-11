import 'package:flutter/material.dart';

// Responsive Sidebar Widget with navigation items
class SidebarWidget extends StatelessWidget {
  final bool isCompact;
  
  const SidebarWidget({
    Key? key,
    this.isCompact = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: isCompact ? 80 : 230,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo section
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12, 
              horizontal: isCompact ? 8 : 16
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset( 
                  'images/adstacks_logo.png',
                  height: isCompact ? 60 : 80,
                  width: isCompact ? 60 : 80,
                ),
              ],
            ),
          ),
          
          // Profile section - simplified in compact mode
          Container(
            padding: EdgeInsets.symmetric(vertical: isCompact ? 12 : 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'images/devarsh_profile_pic.png',
                      height: isCompact ? 50 : 80,
                      width: isCompact ? 50 : 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (!isCompact) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Devarsh Mehta',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Navigation menu
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem('Home', Icons.home, true, isCompact),
                _buildNavItem('Employees', Icons.people_outline, false, isCompact),
                _buildNavItem('Attendance', Icons.list_alt_outlined, false, isCompact),
                _buildNavItem('Summary', Icons.calendar_today_outlined, false, isCompact),
                _buildNavItem('Information', Icons.info_outline, false, isCompact),
                
                // Workspaces section - only show if not compact
                if (!isCompact)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'WORKSPACES',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        Icon(Icons.add, size: 20, color: Colors.indigo),
                      ],
                    ),
                  ),
                
                // Only show expandable items if not in compact mode
                if (!isCompact) ...[
                  _buildExpandableNavItem('Adstacks'),
                  _buildExpandableNavItem('Finance'),
                ],
              ],
            ),
          ),
          
          // Bottom options (Settings and Logout)
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFF0F0F0), width: 1),
              ),
            ),
            child: Column(
              children: [
                _buildNavItem('Setting', Icons.settings_outlined, false, isCompact),
                _buildNavItem('Logout', Icons.logout, false, isCompact),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(String title, IconData icon, bool isActive, bool isCompact) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 2, 
        horizontal: isCompact ? 10 : 0
      ),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFF0F0F0) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: isCompact 
        ? _buildCompactNavItem(icon, isActive)
        : _buildFullNavItem(title, icon, isActive),
    );
  }
  
  Widget _buildFullNavItem(String title, IconData icon, bool isActive) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.indigo : Colors.grey[700],
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.indigo : Colors.grey[800],
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      dense: true,
      visualDensity: const VisualDensity(vertical: -1),
    );
  }
  
  Widget _buildCompactNavItem(IconData icon, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Icon(
          icon,
          color: isActive ? Colors.indigo : Colors.grey[700],
          size: 24,
        ),
      ),
    );
  }
  
  Widget _buildExpandableNavItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_down,
        size: 18,
      ),
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
    );
  }
}