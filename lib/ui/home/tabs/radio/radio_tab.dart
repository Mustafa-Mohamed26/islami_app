import 'package:flutter/material.dart';
import 'package:islami_app/ui/home/tabs/radio/radio_section.dart';
import 'package:islami_app/ui/home/tabs/radio/reciters_section.dart';
import 'package:islami_app/util/app_color.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> with TickerProviderStateMixin {
  late TabController _tabController; // Controller to manage the tabs in the RadioTab widget

  // Initialize the state and set up the TabController
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // <-- use 'this'
  }

  // Dispose the TabController when the widget is disposed
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Build the RadioTab widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [_buildTabBar(), _buildTabViews()]));
  }

  // Build the TabBar widget
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.blackBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColor.blackColor,
        unselectedLabelColor: AppColor.whiteColor,
        indicator: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        tabs: const [
          Tab(child: Text("Radio")),
          Tab(child: Text("Reciters")),
        ],
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),
    );
  }

  // Build the TabBarView widget to display the content of each tab
  Widget _buildTabViews() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const [RadioSection(), RecitersSection()],
      ),
    );
  }
}
