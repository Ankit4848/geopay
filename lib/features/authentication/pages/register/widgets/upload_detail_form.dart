import 'dart:io';

import 'package:bounce/bounce.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fintech/features/authentication/pages/register/controller/register_controller.dart';
import 'package:fintech/features/authentication/pages/register/model/CompanyDisplayDataModel.dart';
import 'package:fintech/features/kyc/controller/kyc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/core.dart';

class UploadDetailsScreen extends StatefulWidget {
  const UploadDetailsScreen({super.key});

  @override
  State<UploadDetailsScreen> createState() => _UploadDetailsScreenState();
}

class _UploadDetailsScreenState extends State<UploadDetailsScreen> {
  RegisterController registerController = Get.find();
  KycController kycController = Get.find();

  List<PlatformFile> pickedFiles = [];

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        pickedFiles = result.files;

        if (registerController.selectedDirector != null &&
            registerController.selectedDocument != null) {
          String directorName = registerController.selectedDirector!.name!;
          String documentName = registerController.selectedDocument!.label!;

          registerController.uploadedFiles.putIfAbsent(directorName, () => {});
          registerController.uploadedFiles[directorName]!
              .putIfAbsent(documentName, () => []);

          registerController.uploadedFiles[directorName]![documentName] =
              List.from(pickedFiles);
        }
      });
    }
  }

  Future<bool> uploadDocument() async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  Widget buildFilePreview() {
    if (pickedFiles.isEmpty) return SizedBox();

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pickedFiles.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final file = pickedFiles[index];
          final isImage = file.extension == 'jpg' ||
              file.extension == 'jpeg' ||
              file.extension == 'png';

          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 120,
                  height: 160,
                  color: Colors.grey.shade200,
                  child: isImage && file.path != null
                      ? Image.file(File(file.path!), fit: BoxFit.cover)
                      : Center(child: Text("No preview")),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Column(
                  children: [
                    _buildCircleIcon(
                      icon: Icons.edit,
                      color: Colors.blue,
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                          allowMultiple: false,
                        );
                        if (result != null && result.files.isNotEmpty) {
                          setState(() {
                            pickedFiles[index] = result.files.first;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    _buildCircleIcon(
                      icon: Icons.delete,
                      color: Colors.red,
                      onTap: () {
                        setState(() {
                          pickedFiles.removeAt(index);

                          if (pickedFiles.isEmpty &&
                              registerController.selectedDirector != null &&
                              registerController.selectedDocument != null) {
                            registerController.documentStatus[registerController
                                    .selectedDirector!.name!]![
                                registerController
                                    .selectedDocument!.label!] = 'Pending';
                            registerController.uploadedFiles[registerController
                                    .selectedDirector!.name!]![
                                registerController
                                    .selectedDocument!.label!] = [];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCircleIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(6),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }

  Widget buildStatusListForDirector(CompanyDirectors? director) {
    if (director == null) return SizedBox();

    final directorName = director.name!;
    registerController.documentStatus.putIfAbsent(directorName, () => {});

    for (var doc
        in registerController.companyDisplayDataModel!.value!.documentTypes!) {
      if (registerController.companyDisplayDataModel!.value!.companyDetail!
                  .companyDocuments !=
              null &&
          registerController.companyDisplayDataModel!.value!.companyDetail!
              .companyDocuments!.isNotEmpty) {
        final director = registerController
            .companyDisplayDataModel!.value!.companyDetail!.companyDocuments!
            .firstWhere((e) =>
                e.documentTypeId == doc.id &&
                registerController.selectedDirector!.id == e.companyDirectorId);

        print(director.status);
        print(director.status);
        if (director.status == 2) {
          registerController.documentStatus[directorName]!
              .putIfAbsent(doc.label!, () => 'Reject');
          registerController.documentStatus[directorName]!
              .putIfAbsent("reaseon_${doc.label!}", () => director.reason!);
        } else if (director.status == 1) {
          registerController.documentStatus[directorName]!
              .putIfAbsent(doc.label!, () => 'Done');
        } else if (director.status == 0) {
          registerController.documentStatus[directorName]!
              .putIfAbsent(doc.label!, () => 'Done');
        }
      } else {
        registerController.documentStatus[directorName]!
            .putIfAbsent(doc.label!, () => 'Pending');
      }
    }

    return Card(
      margin: EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: registerController
              .companyDisplayDataModel!.value!.documentTypes!
              .map((entry) {
            final docLabel = entry.label!;
            final reson = registerController
                    .documentStatus[directorName]!["reaseon_${docLabel!}"] ??
                '';
            final status =
                registerController.documentStatus[directorName]![docLabel] ??
                    'Pending';
            final isUploaded = status == 'Done';

            return ListTile(
              leading: Icon(
                isUploaded ? Icons.check_circle : Icons.cancel,
                color: isUploaded ? Colors.green : Colors.red,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(docLabel, style: TextStyle(fontSize: 13)),
                  Text(
                    "$reson",
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isUploaded && reson != "")
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          registerController.selectedDocument =
                              registerController.companyDisplayDataModel!.value!
                                  .documentTypes!
                                  .firstWhere((doc) => doc.label == docLabel);
                          pickedFiles = List.from(registerController
                                  .uploadedFiles[directorName]?[docLabel] ??
                              []);
                        });
                      },
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<DocumentTypes> getAvailableDocuments() {
    if (registerController.selectedDirector == null) return [];

    final directorName = registerController.selectedDirector!.name!;
    registerController.documentStatus.putIfAbsent(directorName, () => {});

    return registerController.companyDisplayDataModel!.value!.documentTypes!
        .where((doc) {
      final docLabel = doc.label!;

      var status = 'Pending';
      if (registerController.companyDisplayDataModel!.value!.companyDetail!
                  .companyDocuments !=
              null &&
          registerController.companyDisplayDataModel!.value!.companyDetail!
              .companyDocuments!.isNotEmpty) {
        final director = registerController
            .companyDisplayDataModel!.value!.companyDetail!.companyDocuments!
            .firstWhere((e) {
          return e.documentTypeId == doc.id &&
              registerController.selectedDirector!.id == e.companyDirectorId;
        });

        print(director.status);

        if (director.status == 2) {
          status = (registerController.documentStatus[
                              registerController.selectedDirector!.name!]
                          ?[registerController.selectedDocument?.label] ??
                      '') ==
                  'Done'
              ? 'Done'
              : 'Reject';
        } else if (director.status == 1) {
          status = 'Done';
        } else if (director.status == 0) {
          status = registerController.documentStatus[directorName]![docLabel] ??
              'Done';
        }

        print(status);
      } else {
        status = registerController.documentStatus[directorName]![docLabel] ??
            'Pending';
      }

      // Show document if it's not uploaded yet or is currently selected
      return status != 'Done' ||
          registerController.selectedDocument?.label == docLabel;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "registerController.companyDisplayDataModel!.value!.companyDetail!.companyDirectors!.length");
    print(registerController.selectedDocument);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (registerController.companyDisplayDataModel!.value!.companyDetail!
                  .companyDirectors!.length ==
              1)
            CustomTextField(
              labelText: 'Director Name*',
              errorWidget: kycController.fieldErrors['account_number'] != null
                  ? Text(
                      kycController.fieldErrors['account_number']!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    )
                  : Container(),
              onTap: () {},
              controller: registerController.directerctrl,
              textInputType: TextInputType.number,
              isRequired: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (!Validator.isNotNullOrEmpty(value)) {
                  return "Account No. Can't be empty";
                } else if (value!.isNotEmpty) {
                  if ((int.parse(value) < 11) || (int.parse(value) > 16)) {
                    return "Please enter valid number";
                  }
                }
                return null;
              },
            ),
          if (registerController.companyDisplayDataModel!.value!.companyDetail!
                  .companyDirectors!.length >
              1)
            DropdownButtonFormField<CompanyDirectors>(
              value: registerController.selectedDirector,
              items: registerController.companyDisplayDataModel!.value!
                  .companyDetail!.companyDirectors!
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name!)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  registerController.selectedDirector = value;
                  pickedFiles.clear();
                  registerController.selectedDocument = null;

                  // 🟡 Auto-select first available document
                  final docs = getAvailableDocuments();
                  if (docs.isNotEmpty) {
                    registerController.selectedDocument = docs.first;
                  }
                });
              },
              decoration: InputDecoration(labelText: 'Director *'),
            ),
          SizedBox(height: 10),
          DropdownButtonFormField<DocumentTypes>(
            value: registerController.selectedDocument,
            isDense: true,
            isExpanded: true,
            items: getAvailableDocuments()
                .map((e) => DropdownMenuItem(value: e, child: Text(e.label!)))
                .toList(),
            onChanged: (value) => setState(() {
              registerController.selectedDocument = value;
              pickedFiles.clear();
            }),
            decoration: InputDecoration(labelText: 'Document *'),
          ),
          SizedBox(height: 20),
          Bounce(
            onTap: pickFile,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black, style: BorderStyle.solid),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(59),
                            color: const Color(0x1b2b2b2c),
                          ),
                          child: const Icon(
                            Icons.upload_file,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Click Here to upload your file",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          "JPEG, JPG, PNG, PDF formats up to 2 MB",
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          buildFilePreview(),
          if (pickedFiles.isNotEmpty)
            ElevatedButton(
              onPressed: () async {
                if (registerController.selectedDirector != null &&
                    registerController.selectedDocument != null) {
                  bool uploaded = await uploadDocument();
                  if (uploaded) {
                    final dName = registerController.selectedDirector!.name!;
                    final docLabel =
                        registerController.selectedDocument!.label!;
                    registerController.documentStatus[dName]![docLabel] =
                        'Done';
                    registerController.uploadedFiles[dName]![docLabel] =
                        List.from(pickedFiles);
                    pickedFiles = [];

                    final nextDocs = getAvailableDocuments();
                    if (nextDocs.length > 1) {
                      registerController.selectedDocument = nextDocs[1];
                    } else {
                      registerController.selectedDocument = null;
                    }
                    setState(() {});
                  }
                }
              },
              child: Text(
                (registerController.documentStatus[
                                    registerController.selectedDirector!.name!]
                                ?[registerController.selectedDocument?.label] ??
                            '') ==
                        'Done'
                    ? 'Update'
                    : 'Add',
              ),
            ),
          buildStatusListForDirector(registerController.selectedDirector),
        ],
      ),
    );
  }
}
