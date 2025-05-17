import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sems/admin/utils/financial_chart_widget.dart';
import 'package:sems/core/constants/assets.dart';
import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/features/batches/bloc/batch_bloc.dart';
import 'package:sems/router.dart';
import 'package:sems/shared/utils/snacbar_helper.dart';
import 'package:sems/shared/widget/bottom_cards.dart';
import 'package:sems/admin/utils/header.dart';

import 'package:sems/admin/utils/admin_drawer.dart';
import 'package:sems/shared/widget/header_crousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sems/shared/widget/my_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../profile/cubit/profile_cubit.dart';
import '../../shared/widget/grid_button_widget.dart';
import '../../shared/utils/grid_icon_data.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final sems = context.watch<FirestoreDataCubit>().getUserData();
// Access the BatchState from Bloc
    final batchState = context.watch<BatchBloc>().state;

    // Get the length of batches if the state is BatchLoaded
    final batchLength =
        batchState is BatchLoaded ? batchState.batches.length : 0;

    return Scaffold(
      appBar: myAppBar(context, title: sems?.academyName ?? 'SEMS Admin'),
      drawer: adminDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderSection(),
            const SizedBox(height: 20),
            SizedBox(
              height: 415,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  // mainAxisSpacing: 10,
                  // crossAxisSpacing: 10,
                ),
                itemCount: iconData.length,
                itemBuilder: (context, index) {
                  return GridButton(
                    icon: iconData[index]['icon'],
                    label: iconData[index]['label'],
                    color: iconData[index]['color'],
                    onTap: () {
                      switch (index) {
                        case 0:
                          context.push(AppRoute.batchList.path);
                          break;
                        case 1:
                          context.push(AppRoute.studentOptions.path);
                          break;
                        case 2:
                          context.push(AppRoute.attendance.path);
                          break;
                        case 3:
                          context.push(AppRoute.tutionfees.path);
                          break;
                        case 4:
                          context.push(AppRoute.uploadMaterial.path);
                          break;
                        case 5:
                          context.push(AppRoute.todohome.path);
                          break;
                        case 7:
                          context.push(AppRoute.setting.path);
                          break;
                        case 8:
                          const url =
                              'https://play.google.com/store/apps/details?id=com.rkgroup.papergenerator';
                          try {
                            launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalApplication,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Could not launch URL: $e')),
                            );
                          }
                          break;

                        default:
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                '📢 Coming Soon',
                                style: TextStyle(color: Colors.black),
                              ),
                              backgroundColor: Colors.amberAccent,
                            ),
                          );
                      }
                    },
                  );
                },
              ),
            ),
            BottomCards(
              activeBatches: batchLength,
              inactiveBatches: null,
            ),
            const SizedBox(height: 10),
            const CustomCarousel(imageUrls: [
              "https://picsum.photos/id/1/200/300",
              "https://picsum.photos/id/2/200/300",
              "https://picsum.photos/id/3/200/300",
              "https://picsum.photos/id/4/200/300",
            ]),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                SnackbarHelper.showInfoSnackBar(context, 'Under Development');
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(children: [
                  Image(
                    image: AssetImage(
                      "assets/images/promo1.jpg",
                    ),
                    fit: BoxFit.cover,
                    height: 200,
                    width: 600,
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 10),
            FinancialChartWidget(
              line1Data: [
                FlSpot(0, 1),
                FlSpot(1, 1.5),
                FlSpot(2, 1.4),
                FlSpot(3, 3.4),
                FlSpot(4, 5)
              ],
              line2Data: [
                FlSpot(0, 1),
                FlSpot(1, 1.8),
                FlSpot(2, 1.2),
                FlSpot(3, 2.8),
                FlSpot(4, 8)
              ],
              line1Color: Colors.green,
              line2Color: Colors.red,
              currencySymbol: '₹',
              aspectRatio: 2.0,
              onDataPointTap: (spot, lineIndex) {
                print(
                    'Tapped point: x=${spot.x}, y=${spot.y} on line $lineIndex');
                // Handle tap interaction
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Made with ',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold)),
                Icon(Icons.favorite,
                    color: Colors.red.withOpacity(0.5), size: 28),
                Text(' in India',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
