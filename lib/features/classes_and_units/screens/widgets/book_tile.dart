import 'package:denote_pro/features/auth/controllers/auth_controller.dart';
import 'package:denote_pro/features/classes_and_units/screens/pdf_view.dart';
import 'package:denote_pro/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/units_controller.dart';

class BookTile extends ConsumerWidget {
  final Book book;
  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PdfViewPage(
              pdfUrl: book.path,
              pdfName: book.name,
            ),
          ),
        ),
        onLongPress: () {
          //show a dialog to delete the book
          user.isAdmin
              ? showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete Book"),
                      content: const Text(
                          "Are you sure you want to delete this book?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(unitsControllerProvider.notifier)
                                .deleteBook(
                                  book: book,
                                  context: context,
                                );
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  },
                )
              : null;
        },
        tileColor: Colors.white,
        leading: const Image(
          image: AssetImage(
            "assets/icons/icbook.png",
          ),
          height: 50,
        ),
        title: Text(book.name),
        subtitle: const Text("PDF"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
