import 'package:denote_pro/features/classes_and_units/screens/pdf_view.dart';
import 'package:denote_pro/models/book_model.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
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
