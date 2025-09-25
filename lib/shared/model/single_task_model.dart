import 'dart:convert';

import 'single_task/assigned_by_model.dart';
import 'single_task/car_info_model.dart';
import 'single_task/customer_brand_catalogue_model.dart';
import 'single_task/employee_model.dart';
import 'single_task/request_exchange_model.dart';
import 'single_task/request_handover_model.dart';
import 'single_task/request_maintenance_model.dart';
import 'single_task/steps_model.dart';
import 'single_task/task_location_model.dart';

SingleTaskModel singleTaskModelFromJson(String str) => SingleTaskModel.fromJson(json.decode(str));

class SingleTaskModel {
  final Task? task;
  final CarInfo? carInfo;
  final CarInfo? activeCarInfo;
  final CarInfo? requestCarInfo;

  SingleTaskModel({this.task, this.carInfo, this.activeCarInfo, this.requestCarInfo});

  factory SingleTaskModel.fromJson(Map<String, dynamic> json) => SingleTaskModel(
    task: json["task"] == null ? null : Task.fromJson(json["task"]),
    carInfo: json["carInfo"] == null ? null : CarInfo.fromJson(json["carInfo"]),
    activeCarInfo: json["activeCarInfo"] == null ? null : CarInfo.fromJson(json["activeCarInfo"]),
    requestCarInfo: json["requestCarInfo"] == null ? null : CarInfo.fromJson(json["requestCarInfo"]),
  );
}

class Task {
  final int? id;
  final int? brandId;
  final int? locationId;
  final int? designationId;
  final String? address;
  final String? title;
  final DateTime? date;
  final String? description;
  final int? employeeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final String? taskType;
  final int? currentStep;
  final int? totalSteps;
  final String? note;
  final bool? isAssigned;
  final String? currentStatus;
  final int? carId;
  final int? customerPurchaseCarId;
  final int? contactId;
  final String? issue;
  final String? priority;
  final bool? isIssueReported;
  final DateTime? startTaskDate;
  final DateTime? issueReportedDate;
  final DateTime? completedOn;
  final String? currentState;
  final int? exchangeId;
  final int? returnId;
  final int? handoverId;
  final int? maintananceId;
  final Employee? employee;
  final List<Steps>? steps;
  final TaskLocation? location;
  final CusotmerBrandCatalogue? cusotmerBrandCatalogue;
  final RequestExchange? requestExchange;
  final RequestHandover? requestHandover;
  final RequestMaintenance? requestMaintenance;
  final RequestHandover? returnRequest;
  final String? type;
  final String? state;
  final int? completionRate;
  final String? deliveryAddress;
  final String? retriveAddress;
  final String? locationName;
  final AssignedBy? assignedBy;

  Task({
    this.id,
    this.brandId,
    this.locationId,
    this.designationId,
    this.address,
    this.title,
    this.date,
    this.description,
    this.employeeId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.taskType,
    this.currentStep,
    this.totalSteps,
    this.note,
    this.isAssigned,
    this.currentStatus,
    this.carId,
    this.customerPurchaseCarId,
    this.contactId,
    this.issue,
    this.priority,
    this.isIssueReported,
    this.startTaskDate,
    this.issueReportedDate,
    this.completedOn,
    this.currentState,
    this.exchangeId,
    this.returnId,
    this.handoverId,
    this.maintananceId,
    this.employee,
    this.steps,
    this.location,
    this.cusotmerBrandCatalogue,
    this.requestExchange,
    this.requestHandover,
    this.requestMaintenance,
    this.returnRequest,
    this.type,
    this.state,
    this.completionRate,
    this.deliveryAddress,
    this.retriveAddress,
    this.locationName,
    this.assignedBy,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    brandId: json["brand_id"],
    locationId: json["locationId"],
    designationId: json["designationId"],
    address: json["address"],
    title: json["title"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    description: json["description"],
    employeeId: json["employeeId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    status: json["status"],
    taskType: json["taskType"],
    currentStep: json["currentStep"],
    totalSteps: json["totalSteps"],
    note: json["note"],
    isAssigned: json["isAssigned"],
    currentStatus: json["currentStatus"],
    carId: json["carId"],
    customerPurchaseCarId: json["customerPurchaseCarId"],
    contactId: json["ContactID"],
    issue: json["issue"],
    priority: json["priority"],
    isIssueReported: json["isIssueReported"],
    startTaskDate: json["startTaskDate"] == null ? null : DateTime.parse(json["startTaskDate"]),
    issueReportedDate: json["issueReportedDate"] == null ? null : DateTime.parse(json["issueReportedDate"]),
    completedOn: json["completedOn"] == null ? null : DateTime.parse(json["completedOn"]),
    currentState: json["currentState"],
    exchangeId: json["exchangeId"],
    returnId: json["returnId"],
    handoverId: json["handoverId"],
    maintananceId: json["maintananceId"],
    employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    steps: json["steps"] == null ? [] : List<Steps>.from(json["steps"]!.map((x) => Steps.fromJson(x))),
    location: json["location"] == null ? null : TaskLocation.fromJson(json["location"]),
    cusotmerBrandCatalogue: json["cusotmerBrandCatalogue"] == null
        ? null
        : CusotmerBrandCatalogue.fromJson(json["cusotmerBrandCatalogue"]),
    requestExchange: json["RequestExchange"] == null ? null : RequestExchange.fromJson(json["RequestExchange"]),
    requestHandover: json["RequestHandover"] == null ? null : RequestHandover.fromJson(json["RequestHandover"]),
    requestMaintenance: json["RequestMaintanainance"] == null
        ? null
        : RequestMaintenance.fromJson(json["RequestMaintanainance"]),
    returnRequest: json["ReturnRequest"] == null ? null : RequestHandover.fromJson(json["ReturnRequest"]),
    type: json["type"],
    state: json["state"],
    completionRate: json["completionRate"],
    deliveryAddress: json["deliveryAddress"],
    retriveAddress: json["retriveAddress"],
    locationName: json["locationName"],
    assignedBy: json["assignedBy"] == null ? null : AssignedBy.fromJson(json["assignedBy"]),
  );
}
