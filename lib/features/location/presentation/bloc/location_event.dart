part of 'location_bloc.dart';

sealed class LocationEvent {}

class StartLocationTracking extends LocationEvent{}


class FinishLocationTracking extends LocationEvent{}
