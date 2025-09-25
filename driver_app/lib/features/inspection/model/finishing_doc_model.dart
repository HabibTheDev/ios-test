import 'dart:io';

class FinishingDocModel {
  final String docName;
  final String? description;
  final File? attachment;
  final String? attachmentInstruction;
  bool checkValue;

  FinishingDocModel({
    required this.docName,
    this.description,
    this.attachment,
    this.attachmentInstruction,
    required this.checkValue,
  });

  static final List<FinishingDocModel> list = [
    FinishingDocModel(
        docName: 'Police reports',
        description: 'Police report files',
        attachmentInstruction: 'JPEG, PNG, PDF. Max size limit 20 MB',
        checkValue: false),
    FinishingDocModel(
        docName: 'Other documents',
        description: 'Towing, recent vehicle upgrades, incident scene, road condition, etc.',
        attachmentInstruction: 'JPEG, PNG, PDF. Max size limit 20 MB',
        checkValue: false),
  ];

  FinishingDocModel copyWith({
    String? docName,
    String? description,
    File? attachment,
    final String? attachmentInstruction,
    bool? checkValue,
  }) {
    return FinishingDocModel(
      docName: docName ?? this.docName,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      attachmentInstruction: attachmentInstruction ?? this.attachmentInstruction,
      checkValue: checkValue ?? this.checkValue,
    );
  }
}
