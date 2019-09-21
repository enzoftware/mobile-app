import 'package:rxdart/rxdart.dart';
import 'package:vost/common/event.dart';
import 'package:vost/domain/managers/district_manager.dart';
import 'package:vost/domain/managers/family_manager.dart';
import 'package:vost/domain/managers/species_manager.dart';
import 'package:vost/domain/managers/status_manager.dart';
import 'package:vost/domain/managers/types_manager.dart';
import 'package:vost/domain/models/district_model.dart';
import 'package:vost/domain/models/family_model.dart';
import 'package:vost/domain/models/species_model.dart';
import 'package:vost/domain/models/status_model.dart';
import 'package:vost/domain/models/type_model.dart';
import 'package:vost/presentation/assets/error_messages.dart';
import 'package:vost/presentation/ui/_base/base_bloc.dart';

class HomeBloc extends BaseBloc {
  static final recentsIndex = 0;
  static final followingIndex = 1;

  static final listIndex = 0;
  static final mapIndex = 1;

  FamilyManager _countyManager;

  /// Event to fetch new data
  var _fetchNewDataSubject = PublishSubject<Event>();

  Sink<Event> get fetchNewDataSink => _fetchNewDataSubject.sink;

  /// Event to relay MockData information to the UI
  var _mockDataSubject = BehaviorSubject<List<FamilyModel>>();

  Stream<List<FamilyModel>> get mockDataStream => _mockDataSubject.stream;

  /// Event to relay information about type of data: "Recents" or "Folowing"
  var currentTypeOfDataSubject = BehaviorSubject<int>(seedValue: 0);

  Sink<int> get currentTypeOfDataSink => currentTypeOfDataSubject.sink;

  Stream<int> get currentTypeOfDataStream => currentTypeOfDataSubject.stream;

  /// Event to change type of data
  var _changeTypeOfDataSubject = PublishSubject<Event>();
  Sink<Event> get changeTypeOfDataSink => _changeTypeOfDataSubject.sink;

  /// Event to relay information about current page
  var currentPageSubject = BehaviorSubject<int>(seedValue: 0);

  Sink<int> get currentPageSink => currentPageSubject.sink;

  Stream<int> get currentPageStream => currentPageSubject.stream;

  /// Event to change page
  var _changePageSubject = PublishSubject<Event>();
  Sink<Event> get changePageSink => _changePageSubject.sink;

  HomeBloc(this._countyManager) {
    disposable.add(_fetchNewDataSubject.stream
        .flatMap((_) => _countyManager.getFamilies())
        .map((base) => base.toList())
        .listen(_mockDataSubject.add, onError: (error) {
      print(error);
      handleOnError(genericErrorMessage);
    }));

    disposable.add(_changeTypeOfDataSubject.stream.listen((_) {
      int currentIndex = currentTypeOfDataSubject.value;
      int newIndex = currentIndex == recentsIndex ? mapIndex : recentsIndex;
      currentTypeOfDataSubject.add(newIndex);
    }));

    disposable.add(_changePageSubject.stream.listen((_) {
      int currentIndex = currentPageSubject.value;
      int newIndex = currentIndex == recentsIndex ? mapIndex : recentsIndex;
      currentPageSubject.add(newIndex);
    }));
  }
}
