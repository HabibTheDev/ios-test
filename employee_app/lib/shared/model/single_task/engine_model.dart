class Engine {
  final String? horsepower;
  final String? netTorque;
  final String? compression;
  final String? engineModel;
  final String? engineValves;
  final String? engineCamshaft;
  final String? emissionStandard;
  final String? engineBlockType;
  final String? engineOrderCode;
  final String? saeNetTorqueRpm;
  final String? alternatorCapacity;
  final dynamic displacementLCi;
  final String? saeNetHorsepowerRpm;
  final String? engineDisplacementUnits;
  final String? engineNumberOfCylinders;

  Engine({
    this.horsepower,
    this.netTorque,
    this.compression,
    this.engineModel,
    this.engineValves,
    this.engineCamshaft,
    this.emissionStandard,
    this.engineBlockType,
    this.engineOrderCode,
    this.saeNetTorqueRpm,
    this.alternatorCapacity,
    this.displacementLCi,
    this.saeNetHorsepowerRpm,
    this.engineDisplacementUnits,
    this.engineNumberOfCylinders,
  });

  factory Engine.fromJson(Map<String, dynamic> json) => Engine(
    horsepower: json["horsepower"],
    netTorque: json["net_torque"],
    compression: json["compression"],
    engineModel: json["engine_model"],
    engineValves: json["engine_valves"],
    engineCamshaft: json["engine_camshaft"],
    emissionStandard: json["emission_standard"],
    engineBlockType: json["engine_block_type"],
    engineOrderCode: json["engine_order_code"],
    saeNetTorqueRpm: json["sae_net_torque_rpm"],
    alternatorCapacity: json["alternator_capacity"],
    displacementLCi: json["displacement_(l_ci)"],
    saeNetHorsepowerRpm: json["sae_net_horsepower_rpm"],
    engineDisplacementUnits: json["engine_displacement_units"],
    engineNumberOfCylinders: json["engine_number_of_cylinders"],
  );
}
