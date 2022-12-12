import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';

class DescriptionExpandedWidget extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final Function() onTap;
  const DescriptionExpandedWidget({
    required this.description,
    required this.isExpanded,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        children: [
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            onTap: onTap,
            title: Text(AppStrings.description,
                style: Theme.of(context).textTheme.bodyText1),
            trailing: Icon(isExpanded
                ? Icons.arrow_drop_up_rounded
                : Icons.arrow_drop_down_rounded),
          ),
          if (isExpanded)
            Text(description, style: Theme.of(context).textTheme.bodyText1),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
