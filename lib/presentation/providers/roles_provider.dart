import 'package:flutter/material.dart';
import 'package:stockit_mobile/core/constants/view_status.dart';
import 'package:stockit_mobile/data/models/role_model.dart';
import 'package:stockit_mobile/services/role_service.dart';

class RolesProvider extends ChangeNotifier {
  final RoleService _roleService;
  RolesProvider(this._roleService);

  List<RoleModel> _roles = [];
  List<RoleModel> get roles => _roles;
  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadRoles() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();

    try {
      _roles = await _roleService.getRoles();
      _viewStatus = ViewStatus.success;
      notifyListeners();
    } catch (e) {
      _viewStatus = ViewStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
