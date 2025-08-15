import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachmeiti/utils/consts/const_colors.dart';

class chartcard extends StatelessWidget {
  const chartcard({super.key, required this.totaltasks, required this.completedtasks});
  final int totaltasks;
  final int completedtasks;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  'Active Tasks',
                  style: GoogleFonts.corben(
                    color: ConstColors.dark,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 8),
                Text('15',style: GoogleFonts.corben(
                    color: ConstColors.dark,
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                  ),),
              ],
            ),
            Spacer(),
            SizedBox(
              width: 60,
              height: 80,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 15,
                      color: Color(0xff464496),
                      radius: 12,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 85,
                      color: Color(0xffe69b57),
                      radius: 12,
                      showTitle: false,
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 25,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [Text('Tasks',style: GoogleFonts.corben(
                    color: ConstColors.dark,
                    fontSize: 20,
                  ),), SizedBox(height: 8), 
              Text('13',style: GoogleFonts.corben(
                    color: ConstColors.dark,
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                  ),)],
            ),
          ],
        ),
      ),
    );
  }
}
