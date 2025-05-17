import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sems/shared/utils/converter_class.dart';
import 'package:sems/shared/utils/custom_textfield.dart';
import 'package:sems/shared/utils/cutom_appbar.dart';
import 'package:sems/shared/utils/date_picker.dart';
import 'package:sems/shared/utils/image_picker.dart';
import 'package:sems/shared/utils/show_dailog_box.dart';
import 'package:sems/shared/utils/snacbar_helper.dart';
import 'package:sems/student/bloc/attachment_bloc.dart';
import 'package:sems/student/bloc/student_bloc.dart';
import 'package:sems/student/model/student_model.dart';
import 'package:sems/student/utils/batch_selector.dart';
import 'package:sems/student/utils/student_dropdown.dart';
import 'package:sems/student/views/attachments_model.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  late final TextEditingController studentIdController;
  late final TextEditingController rollNumberController;
  late final TextEditingController studentNameController;
  late final TextEditingController parentsNameController;
  late final TextEditingController dateOfBirthController;
  late final TextEditingController addressController;
  late final TextEditingController mobileNumberController;
  late final TextEditingController mobileNumber2Controller;
  late final TextEditingController feesAmountController;
  late final TextEditingController startDateController;
  late final TextEditingController classController;
  late final TextEditingController schoolController;
  late final TextEditingController field1Controller;
  late final TextEditingController field2Controller;
  late final TextEditingController field3Controller;
  late final TextEditingController attachmentController;
  String selectBatch = '';
  String feeType = '';

  List<AttachmentsModel> attachmentList = [];

  String? _selectedGender = "Male";

  final _formKey = GlobalKey<FormState>();

  int studentIdRange = 0;

  @override
  void initState() {
    super.initState();
    initilizeControllers();
    context.read<StudentBloc>().add(GetStudentListEvent());
  }

  @override
  void dispose() {
    super.dispose();
    clearFields();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        appBar: const MyCustomAppBar(
            title: 'New Student', isSearchIconVisible: false),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              Center(
                child: InkWell(
                  onTap: () => showImagePicker(context),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 11, 38, 160),
                            width: 2)),
                    child: selectedFile != null
                        ? CircleAvatar(
                            radius: 55,
                            foregroundImage: FileImage(selectedFile!),
                          )
                        : const Icon(
                            Icons.camera_alt,
                            size: 110,
                            color: Color.fromARGB(255, 11, 38, 160),
                          ),
                  ),
                ),
              ),
              BlocConsumer<StudentBloc, StudentState>(
                listener: (context, state) {
                  if (state is StudentLoaded) {
                    if (state.students.isNotEmpty) {
                      studentIdController.text =
                          (state.students.length + 1).toString();
                      studentIdRange = state.students.length + 1;
                    }

                    if (state is StudentAdded) {
                      context.pop();
                    }
                  } else {
                    studentIdController.text = 1.toString();
                  }
                },
                builder: (context, state) {
                  return CustomTextField(
                    title: 'Student ID',
                    controller: studentIdController,
                    isNumeric: true,
                  );
                },
              ),
              CustomTextField(
                title: 'Roll Number(Optional)',
                controller: rollNumberController,
                isNumeric: true,
                isRequired: false,
              ),
              CustomTextField(
                  title: 'Student Name', controller: studentNameController),
              CustomTextField(
                  title: 'Parents\'/ Guardian Name',
                  controller: parentsNameController),
              CustomTextField(
                title: 'Date of Birth',
                controller: dateOfBirthController,
                isDisabled: true,
                onFieldTapped: () => pickDate(context, dateOfBirthController),
              ),
              CustomTextField(
                title: 'Mobile Number',
                controller: mobileNumberController,
                isMobile: true,
                onContactClicked: _fetchContact,
              ),
              CustomTextField(
                title: 'Mobile Number',
                controller: mobileNumber2Controller,
                isMobile: true,
                onContactClicked: _fetchContact,
                isRequired: false,
              ),

              //radio buttons for gender selction
              genderSelector(),
              CustomTextField(title: 'Address', controller: addressController),
              //this is a bloc builder which is used to select batch name
              // selectBatchName(),
              BatchSelector(
                onBatchSelected: (value) {
                  selectBatch = value!;
                },
                initialValue: 'Select Batch Name',
              ),
              StudentDropdown(
                list: const ['Monthly', 'Course Basis'],
                onChanged: (value) => feeType = value,
              ),

              //radio button ends here
              CustomTextField(
                title: 'Fees Amount',
                controller: feesAmountController,
                isNumeric: true,
              ),
              CustomTextField(
                  title: 'Start Date',
                  controller: startDateController,
                  isDisabled: true,
                  onFieldTapped: () => pickDate(context, startDateController)),
              CustomTextField(
                  title: 'Class/Subject', controller: classController),
              CustomTextField(
                title: 'School/College',
                controller: schoolController,
              ),
              CustomTextField(
                title: 'Field 1(Optional)',
                controller: field1Controller,
                isRequired: false,
              ),
              CustomTextField(
                title: 'Field 2(Optional)',
                controller: field2Controller,
                isRequired: false,
              ),
              CustomTextField(
                title: 'Field 3(Optional)',
                controller: field3Controller,
                isRequired: false,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Attachments",
                        style: TextStyle(
                            color: Color.fromARGB(255, 130, 130, 130)),
                        textScaler: TextScaler.linear(1.5),
                      ),
                      TextButton(
                        onPressed: () =>
                            dialogBuilder(context, addAttachments(context)),
                        child: const Text(
                          "ADD",
                          style: TextStyle(
                              color: Color.fromARGB(255, 11, 38, 160)),
                          textScaler: TextScaler.linear(1.5),
                        ),
                      ),
                    ]),
              ),

              BlocConsumer<AttachmentBloc, AttachmentState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: attachmentList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          leading: SizedBox(
                            width: 25,
                            child: Image.memory(
                              attachmentList[index].imageBytes,
                            ),
                          ),
                          title: Text(
                            attachmentList[index].name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 11, 38, 160)),
                            textScaler: const TextScaler.linear(1.3),
                          ),
                          trailing: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        fixedSize: const Size(180, 50),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(180, 50),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectBatch == 'Select Batch Name') {
                            SnackbarHelper.showErrorSnackBar(
                                context, "Please Select Batch Name");
                            return;
                          }
                          if (int.parse(studentIdController.text) <
                              studentIdRange) {
                            SnackbarHelper.showErrorSnackBar(
                                context, "The Student Id is already exist");
                            return;
                          }
                          final Student student = Student(
                            studentId: studentIdController.text.toString(),
                            profileImageBytes: selectedFile != null
                                ? await imageToBytes(selectedFile!.path)
                                : null,
                            rollNumber: rollNumberController.text.toString(),
                            studentName: studentNameController.text.toString(),
                            guardianName: parentsNameController.text.toString(),
                            dateOfBirth: dateOfBirthController.text.toString(),
                            mobileNumber1:
                                mobileNumberController.text.toString(),
                            mobileNumber2:
                                mobileNumber2Controller.text.toString(),
                            gender: _selectedGender ?? 'Male',
                            address: addressController.text.toString(),
                            batchName: selectBatch.toString(),
                            feeType: feeType.toString(),
                            startDate: startDateController.text.toString(),
                            classOrSubject: classController.text.toString(),
                            schoolName: schoolController.text.toString(),
                            optionalField1: field1Controller.text.toString(),
                            optionalField2: field2Controller.text.toString(),
                            optionalField3: field3Controller.text.toString(),
                            //TODO: it need to be change
                            acadmyId: '', uid: '',
                            isActive: true,

                            // attachments: 'sff',
                          );

                          // ignore: use_build_context_synchronously
                          context
                              .read<StudentBloc>()
                              .add(AddStudentEvent(student));

                          if (attachmentList.isNotEmpty) {
                            attachmentList.map((attachment) {
                              // ignore: use_build_context_synchronously
                              context
                                  .read<AttachmentBloc>()
                                  .add(AddAttachmentEvent(attachment));
                            });
                          }
                          // ignore: use_build_context_synchronously
                          context.pop();
                        }
                      },
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 100,
              )
            ]),
          ),
        ),
      ),
    );
  }

  AlertDialog addAttachments(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      // insetPadding: const EdgeInsets.all(5),
      shape: Border.all(
        color: Colors.transparent,
        width: 2,
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Attachment"),
          Text(
            "Enter Attachments Name",
            textScaler: TextScaler.linear(0.6),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(15),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: attachmentController,
                autofocus: true,
                validator: (value) =>
                    value!.isEmpty ? "Please enter Attachment name" : null,
                decoration: const InputDecoration(
                    hintText: 'DL,Adhaar,Any Certificate Name',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => context.pop(),
                    child: const Text("CANCEL")),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.pop();
                      showImagePicker(context, isAttachment: true);
                    }
                  },
                  child: const Text("OK"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // BlocBuilder<BatchBloc, BatchState> selectBatchName() {
  //   return BlocBuilder<BatchBloc, BatchState>(
  //     builder: (context, state) {
  //       List<String> list = ['Select Batch Name'];
  //       if (state is BatchLoaded) {
  //         final List<String> tempList =
  //             state.batches.map((e) => e.batchName).toList();
  //         list.addAll(tempList);
  //       }

  //       return StudentDropdown(
  //         list: list,
  //         onChanged: (value) => selectBatch = value,
  //       );
  //     },
  //   );
  // }

  Row genderSelector() {
    List<String> gendersList = ["Male", "Female", "Others"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: gendersList.map((gender) {
        return Row(
          children: [
            Radio<String>(
              value: gender,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            Text(gender, style: const TextStyle(fontSize: 17)),
            const SizedBox(width: 15),
          ],
        );
      }).toList(),
    );
  }

  //these are all the functions

  void initilizeControllers() {
    studentIdController = TextEditingController();
    rollNumberController = TextEditingController();
    studentNameController = TextEditingController();
    parentsNameController = TextEditingController();
    dateOfBirthController = TextEditingController();
    addressController = TextEditingController();
    mobileNumberController = TextEditingController();
    mobileNumber2Controller = TextEditingController();
    feesAmountController = TextEditingController();
    startDateController = TextEditingController();
    classController = TextEditingController();
    schoolController = TextEditingController();
    field1Controller = TextEditingController();
    field2Controller = TextEditingController();
    field3Controller = TextEditingController();
    attachmentController = TextEditingController();
  }

  void clearFields() {
    studentIdController.clear();
    rollNumberController.clear();
    studentNameController.clear();
    parentsNameController.clear();
    dateOfBirthController.clear();
    addressController.clear();
    mobileNumberController.clear();
    mobileNumber2Controller.clear();
    feesAmountController.clear();
    startDateController.clear();
    classController.clear();
    schoolController.clear();
    field1Controller.clear();
    field2Controller.clear();
    field3Controller.clear();
    attachmentController.clear();
  }

  File? selectedFile; //this one is used for profile image
  File? attachmentFile;

  final ImagePicker picker = ImagePicker();

  //this function is used for getting the image
  void pickImage(ImageSource source, bool isAttachment) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      File file = File(image.path);
      final bytes = await imageToBytes(image.path);
      setState(() {
        if (isAttachment) {
          attachmentFile = file;

          final AttachmentsModel attachment = AttachmentsModel(
            name: attachmentController.text,
            studentId: studentIdController.text,
            imageBytes: bytes,
          );

          attachmentList.add(attachment);
          setState(() {
            attachmentController.clear();
            attachmentFile = null;
          });
          // context.pop();
        } else {
          selectedFile = file;
        }
      });
    }
  }

//this is to show the bottom modal screen
  void showImagePicker(BuildContext context, {bool isAttachment = false}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialog(
          onImagePicked: (ImageSource source) {
            pickImage(source,
                isAttachment); // Implement this function to handle image picking
          },
        );
      },
    );
  }

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

  //this is the contact variable which will hold the contact
  Contact? contact;

  void _fetchContact(TextEditingController controller) async {
    contact = await _contactPicker.selectContact();

    if (contact != null) {
      controller.text = contact?.phoneNumbers?.first
              .replaceAll(' ', '')
              .replaceAll('+91', '') ??
          '';
    }
  }
}
