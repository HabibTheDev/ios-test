class Steps {
  final int? id;
  final int? taskId;
  final int? step;
  final bool? isCompleted;
  final String? status;
  final String? title;
  final String? description;
  final bool? isHandled;
  final bool? isInspection;
  final bool? isLastStep;
  final String? state;
  final String? handledBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Steps({
    this.id,
    this.taskId,
    this.step,
    this.isCompleted,
    this.status,
    this.title,
    this.description,
    this.isHandled,
    this.isInspection,
    this.isLastStep,
    this.state,
    this.handledBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Steps.fromJson(Map<String, dynamic> json) => Steps(
        id: json["id"],
        taskId: json["taskId"],
        step: json["step"],
        isCompleted: json["isCompleted"],
        status: json["status"],
        title: json["title"],
        description: json["description"],
        isHandled: json["isHandled"],
        isInspection: json["isInspection"],
        isLastStep: json["isLastStep"],
        state: json["state"],
        handledBy: json["handledBy"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );
}
