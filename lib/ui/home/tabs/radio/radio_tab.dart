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
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // <-- use 'this'
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Tab Bar (NOT inside AppBar)
          Container(
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
              tabs: [
                Tab(child: Text("Radio")),
                Tab(child: Text("Reciters")),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                RadioSection(),
                RecitersSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
