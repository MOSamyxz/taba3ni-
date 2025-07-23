
 import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taba3ni/config/responsive/responsive.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';
import 'package:taba3ni/core/constants/app_text_styles.dart';
import 'package:taba3ni/features/add_group/presentation/cubit/add_group_cubit.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_button.dart';
import 'package:taba3ni/features/shaerd_widgets/custom_top_bar.dart';
import 'package:taba3ni/features/shaerd_widgets/gradiant_text_field.dart';
import 'package:taba3ni/features/shaerd_widgets/gradient_drop_down_menu.dart';

class AddGroupPageView extends StatelessWidget {
  const AddGroupPageView({
    super.key,
    required this.r,
    required this.textStyle,
    required this.cubit,
  });

  final Responsive r;
  final AppTextStyles textStyle;
  final AddGroupCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: r.padding(3),
        vertical: r.padding(2),
      ),
      child: ListView(
        children: [
          CustomTopBar(
            r: r,
            textStyle: textStyle,
            title: ' إضافة مجموعة',
            icon: Icons.group_add_rounded,
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => context.pop(true),
            ),
          ),
    
          AppSize.verticalSpace(r.hp(2)),
          Text(
            "قم بإنشاء مجموعة جديدة للطلاب وتحديد المواعيد من هنا",
            style: textStyle.heading2.copyWith(
              fontSize: r.sp(4),
              color: AppColors.textSecondary,
            ),
          ),
          AppSize.verticalSpace(r.hp(2)),
    
          GradientTextField(
            controller: cubit.nameController,
            prefix: Icons.group_outlined,
            hintText: 'اسم المجموعة',
            validator: (value) {
              if (value!.isEmpty) {
                return 'يرجى ادخال اسم المجموعة';
              }
              return null;
            },
          ),
          AppSize.verticalSpace(r.hp(2)),
          GradientTextField(
            controller: cubit.notesController,
            prefix: Icons.note_add_outlined,
            hintText: 'ملاحظات',
            validator: (value) {
              if (value!.isEmpty) {
                return 'يرجى ادخال الملاحظات مثل العنوان ';
              }
              return null;
            },
          ),
    
          AppSize.verticalSpace(r.hp(2)),
          const Text(
            'المرحلة الدراسية:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
           GradientDropdownField(
            labelText: 'اختر المرحلة',
            value: cubit.selectedGradeArabic,
            items:
                cubit.gradeOptionsMap.keys.map((label) {
                  return DropdownMenuItem(value: label, child: Text(label));
                }).toList(),
            onChanged: (value) {
              cubit.selectedGradeArabic = value;
              cubit.selectedGradeEnglish = cubit.gradeOptionsMap[value!]!;
              log('Selected grade: ${cubit.selectedGradeEnglish}');
            },
          ),
    
          const SizedBox(height: 20),
          const Text(
            'اختيار الأيام والمواعيد:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...cubit.selectedDays.keys.map((day) {
            final time = cubit.selectedDays[day];
            return ListTile(
              title: Text(day),
              subtitle: Text(
                time != null
                    ? 'الساعة: ${time.format(context)}'
                    : 'لم يتم اختيار الوقت',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () => cubit.pickTime(day, context),
              ),
            );
          }),
          const SizedBox(height: 24),
          CustomButton(
                            onPressed: () => cubit.submit(context),
    
            text:  'حفظ المجموعة' ,
          ) 
        ],
      ),
    );
  }
}
 