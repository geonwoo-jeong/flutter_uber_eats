import 'package:flutter_uber_eats/common/models/model_with_id.dart';

import '../models/cursor_pagination_model.dart';
import '../models/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
