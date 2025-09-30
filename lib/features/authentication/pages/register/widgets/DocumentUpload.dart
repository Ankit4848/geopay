import 'package:bounce/bounce.dart';
import 'package:geopay/core/core.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';


void main() => runApp(MaterialApp(home: DocumentUploadScreen()));

class DocumentUploadScreen extends StatefulWidget {
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  String? selectedDirector;
  String? selectedDocument;
  List<PlatformFile> pickedFiles = [];

  List<String> directorList = ['Director 1', 'Director 2'];

  List<String> documentList = [
    'Memorandum Articles of Association',
    'Registration of Shareholders',
    'Registration of Directors',
    'Proof of Address for Shareholders',
    'Proof of Address for Directors',
    'Government ID for Shareholders',
    'Government ID for Directors',
  ];

  Map<String, Map<String, String>> documentStatus = {};
  Map<String, Map<String, List<PlatformFile>>> uploadedFiles = {};

  @override
  void initState() {
    super.initState();
    for (var director in directorList) {
      documentStatus[director] = {for (var doc in documentList) doc: 'Pending'};
      uploadedFiles[director] = {for (var doc in documentList) doc: []};
    }
  }

  Future<void> pickFile() async {
    try {
      // Use one-time access approach with FilePicker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: true,
        // Use the system's file picker which doesn't require persistent permissions
        withData: false, // Don't load file data in memory
        withReadStream: true, // Use file streams for better memory management
      );

      if (result != null) {
        setState(() {
          pickedFiles = result.files;

          if (selectedDirector != null && selectedDocument != null) {
            uploadedFiles[selectedDirector!]![selectedDocument!] = [];
          }
        });
      }
    } catch (e) {
      print("Error picking files: $e");
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
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
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

                          // Reset status to Pending if all files deleted
                          if (pickedFiles.isEmpty &&
                              selectedDirector != null &&
                              selectedDocument != null) {
                            documentStatus[selectedDirector!]![selectedDocument!] = 'Pending';
                            uploadedFiles[selectedDirector!]![selectedDocument!] = [];
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

  Widget _buildCircleIcon({required IconData icon, required Color color, required VoidCallback onTap}) {
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

  Widget buildStatusListForDirector(String? director) {
    if (director == null) return SizedBox();
    final docMap = documentStatus[director] ?? {};

    return Card(
      margin: EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: docMap.entries.map((entry) {
            final docName = entry.key;
            final status = entry.value;
            final isUploaded = status == 'Done';

            return ListTile(
              leading: Icon(
                isUploaded ? Icons.check_circle : Icons.cancel,
                color: isUploaded ? Colors.green : Colors.red,
              ),
              title: Text(docName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isUploaded ? Colors.green.shade100 : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(status),
                  ),
                  if (isUploaded)
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          selectedDocument = docName;
                          pickedFiles = List.from(uploadedFiles[director]![docName]!);
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

  List<String> getAvailableDocuments() {
    if (selectedDirector == null) return [];

    return documentList.where((doc) {
      final status = documentStatus[selectedDirector!]?[doc] ?? 'Pending';
      return status != 'Done' || doc == selectedDocument;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Upload Required Documents')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedDirector,
              items: directorList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDirector = value;
                  selectedDocument = null;
                  pickedFiles.clear();
                });
              },
              decoration: InputDecoration(labelText: 'Director *'),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedDocument,
              items: getAvailableDocuments()
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() {
                selectedDocument = value;
                pickedFiles.clear();
              }),
              decoration: InputDecoration(labelText: 'Document *'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.upload_file),
              label: Text("Choose File"),
              onPressed: pickFile,
            ),
            buildFilePreview(),
            if (pickedFiles.isNotEmpty)
              ElevatedButton(
                onPressed: () async {
                  if (selectedDirector != null && selectedDocument != null) {
                    bool uploaded = await uploadDocument();
                    if (uploaded) {
                      setState(() {
                        documentStatus[selectedDirector!]![selectedDocument!] = 'Done';
                        uploadedFiles[selectedDirector!]![selectedDocument!] = List.from(pickedFiles);
                        pickedFiles = [];
                      });
                    }
                  }
                },
                child: Text(
                  (documentStatus[selectedDirector!]?[selectedDocument!] ?? '') == 'Done'
                      ? 'Update'
                      : 'Add',
                ),
              ),
            buildStatusListForDirector(selectedDirector),
          ],
        ),
      ),
    );
  }
}











/*
void main() => runApp(MaterialApp(home: DocumentUploadScreen()));

class DocumentUploadScreen extends StatefulWidget {
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  String? selectedDirector;
  String? selectedDocument;
  List<PlatformFile> pickedFiles = [];

  List<String> directorList = ['Director 1', 'Director 2'];
  List<String> documentList = [
    'Memorandum Articles of Association',
    'Registration of Shareholders',
    'Registration of Directors',
    'Proof of Address for Shareholders',
    'Proof of Address for Directors',
    'Government ID for Shareholders',
    'Government ID for Directors',
  ];

  Map<String, Map<String, String>> documentStatus = {};
  Map<String, Map<String, List<PlatformFile>>> uploadedFiles = {};

  @override
  void initState() {
    super.initState();
    for (var director in directorList) {
      documentStatus[director] = {for (var doc in documentList) doc: 'Pending'};
      uploadedFiles[director] = {for (var doc in documentList) doc: []};
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        pickedFiles = result.files;
        // Clear preview if new selection is made
        if (selectedDirector != null && selectedDocument != null) {
          uploadedFiles[selectedDirector!]![selectedDocument!] = [];
        }
      });
    }
  }

  Future<bool> uploadDocument() async {
    await Future.delayed(const Duration(seconds: 1));
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
          final isImage = file.extension == 'jpg' || file.extension == 'jpeg' || file.extension == 'png';

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

              // Top-right buttons
              Positioned(
                top: 6,
                right: 6,
                child: Column(
                  children: [
                    _buildCircleIcon(
                      icon: Icons.edit,
                      color: Colors.blue,
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
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
  Widget _buildCircleIcon({required IconData icon, required Color color, required VoidCallback onTap}) {
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

  Widget buildStatusListForDirector(String? director) {
    if (director == null) return const SizedBox();
    final docMap = documentStatus[director] ?? {};

    return Card(
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: docMap.entries.map((entry) {
            final docName = entry.key;
            final status = entry.value;
            final isUploaded = status == 'Done';

            return ListTile(
              leading: Icon(
                isUploaded ? Icons.check_circle : Icons.cancel,
                color: isUploaded ? Colors.green : Colors.red,
              ),
              title: Text(docName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isUploaded
                          ? Colors.green.shade100
                          : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(status),
                  ),
                  if (isUploaded)
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          selectedDocument = docName;
                          pickedFiles =
                              List.from(uploadedFiles[director]![docName]!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Upload Required Documents')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedDirector,
              items: directorList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => selectedDirector = value),
              decoration: const InputDecoration(labelText: 'Director *'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedDocument,
              items: documentList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() {
                selectedDocument = value;
                pickedFiles.clear();
              }),
              decoration: const InputDecoration(labelText: 'Document *'),
            ),
            const SizedBox(height: 20),
            Bounce(
              onTap: pickFile,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid)),
                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(59),
                          color: const Color(0x1b2b2b2c)),
                      child: const Icon(
                        Icons.upload_file,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Click Here to upload your file",style: TextStyle(
                      color:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("JPEG, JPG, PNG, PDF formats up to 2 MB",style: TextStyle(
                        color:Colors.black,
                        fontSize: 10
                    )),

                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("Choose File"),
              onPressed: pickFile,
            ),
            buildFilePreview(),
            if (pickedFiles.isNotEmpty)
              ElevatedButton(
                onPressed: () async {
                  if (selectedDirector != null && selectedDocument != null) {
                    bool uploaded = await uploadDocument();
                    if (uploaded) {
                      setState(() {
                        documentStatus[selectedDirector!]![selectedDocument!] =
                            'Done';
                        uploadedFiles[selectedDirector!]![selectedDocument!] =
                            List.from(pickedFiles);
                        pickedFiles = [];
                      });
                    }
                  }
                },
                child: Text(documentStatus[selectedDirector!]
                            ?[selectedDocument!] ==
                        'Done'
                    ? 'Update'
                    : 'Add'),
              ),
            buildStatusListForDirector(selectedDirector),
          ],
        ),
      ),
    );
  }
}
*/
