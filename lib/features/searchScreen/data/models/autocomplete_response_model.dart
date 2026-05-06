import '../../domain/entities/auto_complete_entity.dart';

class AutocompleteResponseModel {
  final String? queryComplement;
  final String? businessName;

  AutocompleteResponseModel({required this.queryComplement , required this.businessName});

  // using factory " special type of constructors " : perform the function first on the input then return the object
  factory AutocompleteResponseModel.fromJson(Map<String, dynamic> json)  {
    return AutocompleteResponseModel(
        queryComplement: json['name'] as String?,
        businessName: json['businessName'] as String?
    ) ;
  }

  AutoCompleteResponseEntity toEntity(AutocompleteResponseModel model){
    return AutoCompleteResponseEntity(
        queryComplement: model.queryComplement  ,
      businessName: model.businessName
    );
  }


}
