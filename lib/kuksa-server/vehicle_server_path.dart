// SPDX-License-Identifier: Apache-2.0

class VSPath {
  static const String vehicleTrunkLocked = "Vehicle.Body.Trunk.IsLocked";
  static const String vehicleTrunkOpen = "Vehicle.Body.Trunk.IsOpen";

  static const String vehicleAmbientAirTemperature =
      "Vehicle.AmbientAirTemperature";

  static const String vehicleFrontLeftTire =
      "Vehicle.Chassis.Axle.Row1.Wheel.Left.Tire.Pressure";
  static const String vehicleFrontRightTire =
      "Vehicle.Chassis.Axle.Row1.Wheel.Right.Tire.Pressure";
  static const String vehicleRearLeftTire =
      "Vehicle.Chassis.Axle.Row2.Wheel.Left.Tire.Pressure";

  static const String vehicleRearRightTire =
      "Vehicle.Chassis.Axle.Row2.Wheel.Right.Tire.Pressure";
  static const String vehicleIsChildLockActiveLeft =
      "Vehicle.Cabin.Door.Row2.Left.IsChildLockActive";
  static const String vehicleIsChildLockActiveRight =
      "Vehicle.Cabin.Door.Row2.Right.IsChildLockActive";
  static const String vehicleCurrentLongitude =
      "Vehicle.CurrentLocation.Longitude";
  static const String vehicleCurrentLatitude =
      "Vehicle.CurrentLocation.Latitude";

  static const String vehicleInsideTemperature =
      "Vehicle.Cabin.HVAC.AmbientAirTemperature";
  static const String vehicleFrontLeftAc =
      "Vehicle.Cabin.HVAC.Station.Row1.Left.AirDistribution";

  static const String vehicleSpeed = "Vehicle.Speed";
}
