import 'package:rxdart/rxdart.dart';
import 'package:vost/data/remote/services/county_service.dart';
import 'package:vost/data/remote/services/family_service.dart';
import 'package:vost/domain/mappers/county_mapper.dart';
import 'package:vost/domain/mappers/family_mapper.dart';
import 'package:vost/domain/models/county_model.dart';
import 'package:vost/domain/models/family_model.dart';

class FamilyManager {
  FamilyService _service;
  FamilyListResponseMapper _mapper;

  FamilyManager(this._service, this._mapper);

  Observable<List<FamilyModel>> getFamilies() {
    return _service.getFamilies().map(_mapper.map);
  }
}
