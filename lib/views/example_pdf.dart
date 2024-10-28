import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تبدیل به PDF'),
      ),
      body: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final pdf = await _generatePdf();
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => pdf.save(),
              );
            },
            child: Icon(
              Icons.sim_card_download,
              color: Colors.blue,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }

  Future<pw.Document> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('این یک متن نمونه است که به PDF تبدیل شده است.'),
          );
        },
      ),
    );

    return pdf;
  }
}