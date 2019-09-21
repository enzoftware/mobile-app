import 'package:rxdart/rxdart.dart';
import 'package:vost/data/remote/endpoints/county_endpoints.dart';
import 'package:vost/data/remote/endpoints/family_endpoints.dart';
import 'package:vost/data/remote/models/response/base_list_response.dart';

class FamilyService {
  FamilyEndpoints _endpoints;

  FamilyService(this._endpoints);

  Observable<BaseListResponse> getFamilies() {
    return Observable.fromFuture(_endpoints.getFamilies())
        .map((response) => BaseListResponse.fromJson(response.data));
  }
}
