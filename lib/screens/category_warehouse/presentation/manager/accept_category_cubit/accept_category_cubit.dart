import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'accept_category_state.dart';

class AcceptRequestCubit extends Cubit<AcceptRequestState> {

  static AcceptRequestCubit get(context) => BlocProvider.of(context);

  AcceptRequestCubit(this.categoryRepo) : super(AcceptRequestInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchAcceptRequest({
  required int id,
}) async {
    emit(AcceptRequestLoading());
    var result = await categoryRepo.fetchAcceptRequest(id: id);

    result.fold((failure) {
      emit(AcceptRequestFailure(failure.errorMessage));
    }, (acceptResult) {
      emit(AcceptRequestSuccess(acceptResult));
    },
    );
  }
}