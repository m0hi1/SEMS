import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/features/batches/bloc/batch_bloc.dart';
import 'package:sems/features/batches/day_selector.dart';
import 'package:sems/shared/utils/custom_textfield.dart';
import 'package:sems/shared/utils/cutom_appbar.dart';
import 'package:sems/shared/utils/full_space_button.dart';
import 'package:sems/shared/utils/logger.dart';
import 'package:sems/shared/utils/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

//this are used to create a new batch

class NewBatch extends StatefulWidget {
  final BatchModel? batch;
  const NewBatch({super.key, this.batch});

  @override
  State<NewBatch> createState() => _NewBatchState();
}

class _NewBatchState extends State<NewBatch> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController batchIdController;
  late final TextEditingController batchNameController;
  late final TextEditingController batchAdminController;
  late final TextEditingController batchTimeController;
  late final TextEditingController batchMaximumSlotsController;
  late final TextEditingController batchLocationController;

  List<String> days = [];

  List<String> daysName = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];

  bool isSwitched = true;

  @override
  void initState() {
    super.initState();
    inilizeControllers();

    if (widget.batch != null) {
      batchIdController.text = widget.batch!.batchId.toString();
      isSwitched = widget.batch!.isActive == 'Active' ? true : false;
      batchIdController.text = widget.batch!.batchId.toString();
      batchNameController.text = widget.batch!.batchName;
      batchAdminController.text = widget.batch!.batchAdmin;
      batchTimeController.text = widget.batch!.batchTime;
      batchMaximumSlotsController.text =
          widget.batch!.batchMaximumSlots.toString();
      batchLocationController.text = widget.batch!.batchLocation;

      widget.batch!.batchDays.split(',').forEach((element) {
        days.add(element);
      });

      // for (int i = 0; i < widget.batch!.batchDays.length; i++) {
      //   days.add(widget.batch!.batchDays[i].toString());
      // }
    }
  }

  void inilizeControllers() {
    batchNameController = TextEditingController();
    batchLocationController = TextEditingController();
    batchAdminController = TextEditingController();
    batchTimeController = TextEditingController();
    batchMaximumSlotsController = TextEditingController();
    batchIdController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    batchNameController.dispose();
    batchLocationController.dispose();
    batchAdminController.dispose();
    batchTimeController.dispose();
    batchMaximumSlotsController.dispose();
    batchIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyCustomAppBar(
          title: 'New Batch',
          isSearchIconVisible: false,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.batch != null)
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Active',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                          textScaler: TextScaler.linear(1.5)),
                      Switch(
                        activeColor: const Color.fromARGB(220, 12, 1, 110),
                        value: isSwitched,
                        onChanged: (val) {
                          setState(() {
                            isSwitched = val;
                          });
                        },
                      ),
                    ]),
              if (widget.batch != null)
                CustomTextField(
                  title: 'Batch Id',
                  controller: batchIdController,
                  isNumeric: true,
                  isDisabled: true,
                ),
              CustomTextField(
                  title: 'Batch Name', controller: batchNameController),
              CustomTextField(
                  title: 'Batch Location', controller: batchLocationController),
              CustomTextField(
                  title: 'Batch Admin', controller: batchAdminController),
              CustomTimePicker(
                timeController: batchTimeController,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  'Batch Days',
                  textScaler: TextScaler.linear(1.5),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: daysName
                    .map((day) => SelectDayCard(
                          day: day,
                          days: days,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  title: 'Batch Maximum Slots',
                  isNumeric: true,
                  controller: batchMaximumSlotsController),
              FullSpaceButton(
                onPressed: () {
                  //this string is used here because sqflite database dosent support list
                  final String dayString = days.join(',');

                  //validation is done here
                  if (_formKey.currentState!.validate()) {
                    if (days.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select atleast one day'),
                        ),
                      );
                      return;
                    }

                    final batch = BatchModel(
                      batchId: widget.batch != null
                          ? int.parse(batchIdController.text)
                          : null,
                      batchName: batchNameController.text,
                      batchLocation: batchLocationController.text,
                      batchAdmin: batchAdminController.text,
                      batchTime: batchTimeController.text,
                      batchDays: dayString,
                      isActive: isSwitched ? 'Active' : 'Inactive',
                      batchMaximumSlots:
                          int.parse(batchMaximumSlotsController.text),
                      createdAt: DateTime.now().toIso8601String(),
                    );

                    //this here checks if it is update or save
                    if (widget.batch != null) {
                      context.read<BatchBloc>().add(UpdateBatchEvent(batch));
                    } else {
                      logger.w('Batch: $batch');
                      context.read<BatchBloc>().add(AddBatchEvent(batch));
                    }
                    context.pop();
                  }
                },
                label: widget.batch != null ? 'Update Batch' : 'Save Batch',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
