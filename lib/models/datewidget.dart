// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/modelprovider.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Consumer<ModelProvider>(
      builder: (context, value, child) {
        return GestureDetector(
        onTap: () {
          pickDateRange();
        },
        child: Container(
               width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
              height: Values.mobileDatePickerHeight,
              padding: ProjectPadding.horizontalPadding(value: 20),
              margin: ProjectPadding.horizontalPadding(value: 20) + const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: ProjectColors.transparent,
                  border: Border.all(color: ProjectColors.greyColor, width: 1),
                  borderRadius: BorderRadius.circular(Values.contactCardRadius / 2)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    ProjectText.rText(
                        text: '${DateFormat.MMMd().format(value.startDate)} - ',
                        fontSize: Values.fitValue,
                        color: ProjectColors.customColor),
                    ProjectText.rText(
                        text: DateFormat.MMMd().format(value.endDate),
                        fontSize: Values.fitValue,
                        color: ProjectColors.customColor)
                  ],
                ),
                Icon(Icons.date_range, color: ProjectColors.greyColor, size: Values.lValue)
              ]),
            ));
      },
    );
  }

DateTimeRange dateRange = DateTimeRange(start: ModelProvider().startDate, end: ModelProvider().endDate);

Future pickDateRange() async {
  DateTimeRange? newDateRange = await showDateRangePicker(
    context: context,
    initialDateRange: dateRange,
    firstDate: DateTime.now().subtract(const Duration(days: 30)),
    lastDate: DateTime.now().add(const Duration(days: 1)),
    cancelText: 'close',
    confirmText: 'confirm',
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.greenAccent,
            onPrimary: ProjectColors.themeColorMOD3,
            surface: ProjectColors.themeColorMOD3,
            onSurface: Colors.white,
          ),
          dialogBackgroundColor: ProjectColors.opacityDEFb(0.95),
        ),
        child: child!,
      );
    },
  );
  if (newDateRange == null) {
    return;
  } else {
    Provider.of<ModelProvider>(context, listen: false).setStartDate(newDateRange.start);
    Provider.of<ModelProvider>(context, listen: false).setEndDate(newDateRange.end);
  }
}
}
