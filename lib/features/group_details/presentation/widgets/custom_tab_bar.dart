import 'package:flutter/material.dart';
import 'package:taba3ni/core/constants/app_colors.dart';

class StackOver extends StatefulWidget {
  const StackOver({super.key, required this.tabs, required this.children, required this.height});
final List<Widget> tabs;
  final List<Widget> children;
final double height;
  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<StackOver>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [

             Container(
              height: widget.height,
                  decoration: BoxDecoration(
                color: Colors.grey,
                 borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.all(0),
                 dividerHeight: 0,
                 indicatorSize: TabBarIndicatorSize.tab,
                 indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
               
                  color: AppColors.primary,
                ),
                labelColor: AppColors.lightBackground,
                unselectedLabelColor: Colors.black,
                tabs:widget.tabs  ,
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:widget. children,
              ),
            ),
          ],
        );
  }
}