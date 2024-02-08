import 'dart:io';

import 'package:denote_pro/core/common/loader.dart';
import 'package:denote_pro/features/auth/controllers/auth_controller.dart';
import 'package:denote_pro/features/classes_and_units/controller/units_controller.dart';
import 'package:denote_pro/features/classes_and_units/screens/widgets/book_tile.dart';
import 'package:denote_pro/models/unit_model.dart';
import 'package:denote_pro/theme/textstyles.dart';
import 'package:denote_pro/theme/theme_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewUnit extends ConsumerStatefulWidget {
  final UnitModel unit;
  const ViewUnit({super.key, required this.unit});

  @override
  ConsumerState<ViewUnit> createState() => _ViewUnitState();
}

class _ViewUnitState extends ConsumerState<ViewUnit> {
  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    final bool isUploadingPDF = ref.watch(unitsControllerProvider);
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unit.unitName),
        actions: [
          IconButton(
            onPressed: () {
              //showModalBottomSheet
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Unit Details",
                            style: TextStyles.bold(20),
                          ),
                        ),
                        //divider
                        const Divider(
                          color: AppTheme.greyColor,
                          thickness: 1,
                        ),

                        RichText(
                          text: TextSpan(
                            text: "Unit: ",
                            style: TextStyles.bold(20),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.unit.unitName,
                                style: TextStyles.normal(20).copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            text: "Unit Code: ",
                            style: TextStyles.bold(20),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.unit.unitCode,
                                style: TextStyles.normal(20).copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        //lecturer
                        RichText(
                          text: TextSpan(
                            text: "Lecturer: ",
                            style: TextStyles.bold(20),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.unit.lecturer,
                                style: TextStyles.normal(20).copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.more),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ref.watch(booksInAUnitStreamProvider(widget.unit.unitId)).when(
                data: (books) {
                  //if books is empty
                  if (books.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/icempty.png",
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "No Books in this unit yet",
                            style: TextStyles.bold(20),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return BookTile(book: book);
                    },
                  );
                },
                error: (error, stackTrace) {
                  print("Error: $error");
                  return const Center(
                    child: Text(
                      "Something went wrong while fetching books",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
                loading: () => const Loader(),
              )),
      floatingActionButton: user.isAdmin
          ? FloatingActionButton(
              onPressed: () {
                //show Bottomsheet to add a book - no form inside the bottomsheet,just a plus icon which picks the pdf,then if the pdf is picked,display the name of the pdf and a button to upload the pdf
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return AddBookToUnitBottomSheet(
                      unit: widget.unit,
                      selectedFile: selectedFile,
                      onFileSelected: (file) {
                        setState(() {
                          selectedFile = file;
                        });
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox.shrink(),
    );
  }
}

final errorProvider = StateProvider<String?>((ref) {
  return null;
});

//bottomsheet to add a book to a unit
class AddBookToUnitBottomSheet extends ConsumerWidget {
  final UnitModel unit;
  final File? selectedFile;
  final Function(File?) onFileSelected;
  const AddBookToUnitBottomSheet({
    super.key,
    required this.unit,
    required this.selectedFile,
    required this.onFileSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isUploadingPDF = ref.watch(unitsControllerProvider);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Add Book",
              style: TextStyles.bold(20),
            ),
          ),
          //divider
          const Divider(
            color: AppTheme.greyColor,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          //pick pdf
          ElevatedButton.icon(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );
              if (result != null) {
                onFileSelected(File(result.files.single.path!));
                ref.watch(errorProvider.notifier).update((state) => null);
              }
            },
            icon: const Icon(Icons.upload_file),
            label: const Text("Pick PDF"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              foregroundColor: Colors.white,
            ),
          ),
          ref.watch(errorProvider) != null
              ? Text(
                  ref.watch(errorProvider)!,
                  style: TextStyles.normal(20).copyWith(
                    color: Colors.red,
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 20),
          //display the name of the pdf
          if (selectedFile != null)
            Text(
              selectedFile!.path.split('/').last,
              style: TextStyles.normal(20).copyWith(
                color: Colors.black,
              ),
            ),
          const SizedBox(height: 20),
          //upload button
          isUploadingPDF
              ? const Loader()
              : ElevatedButton(
                  onPressed: () {
                    if (selectedFile != null) {
                      ref
                          .read(unitsControllerProvider.notifier)
                          .uploadPDFAndSaveDetails(
                            uploadedBy: ref.watch(userProvider)!.name,
                            unit: unit,
                            pdfFile: selectedFile!,
                            context: context,
                          );
                    } else {
                      ref
                          .read(errorProvider.notifier)
                          .update((state) => "Please Pick a file");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Upload PDF",
                    style: TextStyles.normal(20).copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
