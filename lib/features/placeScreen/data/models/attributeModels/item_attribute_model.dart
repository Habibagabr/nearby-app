import '../../../domain/entities/placeEntity/item_attribute_entity.dart';

abstract class ItemAttributesModel<E extends ItemAttributesEntity> {
  const ItemAttributesModel();

  E toEntity();
}
