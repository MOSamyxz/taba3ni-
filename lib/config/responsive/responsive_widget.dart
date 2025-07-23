 
import 'package:flutter/material.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
 
typedef ResponsiveBuilder = Widget Function(BuildContext context, Responsive r);

class ResponsiveWidget extends StatelessWidget {
  final ResponsiveBuilder builder;

  const ResponsiveWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return builder(context, responsive);
  }
}
