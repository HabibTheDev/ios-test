import 'package:flutter/material.dart';
import 'canceled_contract_vehicle_tile.dart';
import 'default_vehicle_tile.dart';
import 'exchange_vehicle_tile.dart';
import 'maintenance_vehicle_tile.dart';
import 'my_vehicle_explore_car_tile.dart';
import 'new_contract_vehicle_tile.dart';
import 'revoked_vehicle_tile.dart';

import '../../../../shared/utils/enums.dart';
import '../../model/vehicle_model.dart';

class MyVehicleTile extends StatelessWidget {
  const MyVehicleTile({super.key, required this.vehicle});
  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) => vehicle.currentStatus == MyVehicleType.newContract.value
      ? NewContractVehicleTile(vehicle: vehicle)
      : vehicle.currentStatus == MyVehicleType.canceledContract.value
          ? CanceledContractVehicleTile(myVehicleModel: vehicle)
          : vehicle.currentStatus == MyVehicleType.exchange.value
              ? ExchangeVehicleTile(myVehicleModel: vehicle)
              : vehicle.currentStatus == MyVehicleType.maintenance.value
                  ? MaintenanceVehicleTile(myVehicleModel: vehicle)
                  : vehicle.currentStatus == MyVehicleType.revokedAndBlocked.value
                      ? RevokedVehicleTile(myVehicleModel: vehicle)
                      : vehicle.currentStatus == MyVehicleType.exploreCar.value
                          ? MyVehicleExploreCarTile(myVehicleModel: vehicle)
                          : DefaultVehicleTile(myVehicleModel: vehicle);
}
