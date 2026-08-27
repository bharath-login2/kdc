import 'package:flutter/material.dart';
import '../core/common.dart';
import '../models/lead_management/addLeadCommonDataModel.dart';
import '../models/lead_management/connectingChannelModel.dart';
import '../models/lead_management/connectingStatusModel.dart';
import '../models/lead_management/connectingReasonsModel.dart';
import '../models/lead_management/reduceRejectionMethodModel.dart';
import '../models/lead_management/rejectionRelationActionModel.dart';
import '../models/lead_management/prospectParametersModel.dart';
import '../models/lead_management/productCustomizationParameterModel.dart';
import '../models/lead_management/relationshipParametersModel.dart';
import '../models/lead_management/callResultReasonModel.dart';
import '../service/service.dart';

class LeadDynamicFormData {
  String? connectingChannelId;
  String? connectingChannelName;
  String? connectingStatusId;
  String? connectingStatusName;
  String? connectingReasonId;
  String? connectingReasonName;
  String? connectingReasonType;
  String? callStatusId;
  String? callStatusName;
  String? leadStatus; // 'Active' or 'Cancel'
  String? callStatusReasonId;
  String? callStatusReasonName;

  List<String> rejectionCategoryIds = [];
  Map<String, String> rejectionCategoryReasons = {}; // catId -> reasonForInterest

  String? triedToReduceRejection; // 'Yes' or 'No'
  List<String> reduceRejectionMethodIds = [];
  String? reductionChallenges;

  String? rejectionToRelation; // 'Yes' or 'No'
  List<String> relationActionIds = [];
  String? relationChallenges;

  String? prospectQualified; // 'Yes' or 'No'
  List<String> prospectParameterIds = [];
  String? sharedPurpose;
  String? sharedPainPoint;
  String? prospectChallenges;

  String? productCustomization; // 'Yes' or 'No'
  List<String> customizationParameterIds = [];
  String? customizationChallenges;

  // Extra fields
  String? customerSummary;
  String? customerChallenges;
  int? customerRating; // 1-10

  String? relationshipBuild; // 'Yes' or 'No'
  List<String> relationshipParameterIds = [];
  String? relationshipChallenges;

  LeadDynamicFormData();
}

class LeadDynamicFormWidget extends StatefulWidget {
  final String token;
  final AddLeadCommonDataModel? commonDetails;
  final Function(LeadDynamicFormData formData)? onChanged;
  final bool isReadOnly;

  // Optional initial values for edit mode restoration
  final String? initialChannelId;
  final String? initialStatusId;
  final String? initialReasonId;
  final String? initialCallStatusId;
  final String? initialCallStatusReasonId;
  final Map<String, String>? initialRejectionCategoryReasons;
  final String? initialTriedToReduce;
  final List<String>? initialReduceMethods;
  final String? initialReductionChallenges;
  final String? initialRejectionToRelation;
  final List<String>? initialRelationActions;
  final String? initialRelationChallenges;
  final String? initialProspectQualified;
  final List<String>? initialProspectParams;
  final Map<String, Map<String, String>>? initialProspectParamValues;
  final String? initialProspectPurpose;
  final String? initialProspectPainPoint;
  final String? initialProspectChallenges;
  final String? initialProductCustomization;
  final List<String>? initialCustomizationParams;
  final String? initialCustomizationChallenges;
  final String? initialCustomerSummary;
  final String? initialCustomerChallenges;
  final int? initialCustomerRating;
  final String? initialRelationshipBuild;
  final List<String>? initialRelationshipParams;
  final String? initialRelationshipChallenges;

  const LeadDynamicFormWidget({
    super.key,
    required this.token,
    this.commonDetails,
    this.onChanged,
    this.isReadOnly = false,
    this.initialChannelId,
    this.initialStatusId,
    this.initialReasonId,
    this.initialCallStatusId,
    this.initialCallStatusReasonId,
    this.initialRejectionCategoryReasons,
    this.initialTriedToReduce,
    this.initialReduceMethods,
    this.initialReductionChallenges,
    this.initialRejectionToRelation,
    this.initialRelationActions,
    this.initialRelationChallenges,
    this.initialProspectQualified,
    this.initialProspectParams,
    this.initialProspectParamValues,
    this.initialProspectPurpose,
    this.initialProspectPainPoint,
    this.initialProspectChallenges,
    this.initialProductCustomization,
    this.initialCustomizationParams,
    this.initialCustomizationChallenges,
    this.initialCustomerSummary,
    this.initialCustomerChallenges,
    this.initialCustomerRating,
    this.initialRelationshipBuild,
    this.initialRelationshipParams,
    this.initialRelationshipChallenges,
  });

  @override
  State<LeadDynamicFormWidget> createState() => LeadDynamicFormWidgetState();
}

class LeadDynamicFormWidgetState extends State<LeadDynamicFormWidget> {
  // 1. Connecting Channel
  ConnectingChannelModel? connectingChannelModel;
  ConnectingChannelData? selectedConnectingChannel;
  bool isLoadingChannel = false;

  // 2. Connecting Status
  ConnectingStatusModel? connectingStatusModel;
  ConnectingStatusData? selectedConnectingStatus;
  bool isLoadingConnectingStatus = false;

  // 3. Connecting Reason
  ConnectingReasonsModel? connectingReasonsModel;
  ConnectingReasonData? selectedConnectingReason;
  bool isLoadingConnectingReasons = false;

  // 4. Call Status & Lead Status
  CallResultNew? selectedCallStatus;
  String? leadStatus; // 'Active' or 'Cancel' (auto-assigned from selectedCallStatus.type)

  // 5. Call Status Reason / Rejection Categories
  CallResultResonModel? callStatusReasonModel;
  Set<String> selectedRejectionCategoryIds = {};
  final Map<String, TextEditingController> rejectionReasonControllers = {};
  bool isLoadingCallStatusReason = false;

  // 6 & 7. Tried to Reduce Rejection
  String? triedToReduceRejection; // 'Yes' or 'No'
  ReduceRejectionMethodModel? reduceRejectionMethodModel;
  Set<String> selectedReduceRejectionMethodIds = {};
  bool isLoadingReduceRejection = false;
  final TextEditingController reductionChallengesController = TextEditingController();

  // 8. Rejection to Relation
  String? rejectionToRelation; // 'Yes' or 'No'
  RejectionRelationActionModel? rejectionRelationActionModel;
  Set<String> selectedRelationActionIds = {};
  bool isLoadingRelationAction = false;
  final TextEditingController relationChallengesController = TextEditingController();

  // 9, 10, 11. Prospect Qualified
  String? prospectQualified; // 'Yes' or 'No'
  ProspectParametersModel? prospectParametersModel;
  Set<String> selectedProspectParameterIds = {};
  bool isLoadingProspectParams = false;
  // Shared single Purpose & Pain Point for all selected prospect parameters
  final TextEditingController sharedProspectPurposeController = TextEditingController();
  final TextEditingController sharedProspectPainPointController = TextEditingController();
  final TextEditingController prospectChallengesController = TextEditingController();

  // 12, 13. Product Customization
  String? productCustomization; // 'Yes' or 'No'
  ProductCustomizationParameterModel? productCustomizationParameterModel;
  Set<String> selectedCustomizationParameterIds = {};
  bool isLoadingCustomizationParams = false;
  final TextEditingController customizationChallengesController = TextEditingController();

  // Extra fields
  final TextEditingController customerSummaryController = TextEditingController();
  final TextEditingController customerChallengesController = TextEditingController();
  int customerRating = 0; // 0 = not set, 1-10

  // Relationship Build
  String? relationshipBuild; // 'Yes' or 'No'
  RelationshipParametersModel? relationshipParameterModel;
  Set<String> selectedRelationshipParameterIds = {};
  bool isLoadingRelationshipParams = false;
  final TextEditingController relationshipChallengesController = TextEditingController();

  bool get _hasConnectingReasons {
    return connectingReasonsModel?.data != null &&
        connectingReasonsModel!.data!.isNotEmpty;
  }

  bool get _canSelectCallStatus {
    if (selectedConnectingStatus == null) return false;
    if (_hasConnectingReasons) {
      return selectedConnectingReason != null;
    }
    return true;
  }

  bool get _isNeedProspectParamSelected {
    if (selectedProspectParameterIds.isEmpty) return false;
    var items = prospectParametersModel?.data ?? [];
    for (var item in items) {
      if (item.parameterId != null && selectedProspectParameterIds.contains(item.parameterId)) {
        final name = (item.parameterName ?? '').trim().toLowerCase();
        if (name == 'need') {
          return true;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    reductionChallengesController.dispose();
    relationChallengesController.dispose();
    prospectChallengesController.dispose();
    customizationChallengesController.dispose();
    sharedProspectPurposeController.dispose();
    sharedProspectPainPointController.dispose();
    customerSummaryController.dispose();
    customerChallengesController.dispose();
    relationshipChallengesController.dispose();
    for (var ctrl in rejectionReasonControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _notifyParent() {
    if (widget.onChanged != null) {
      widget.onChanged!(getFormData());
    }
  }

  LeadDynamicFormData getFormData() {
    LeadDynamicFormData data = LeadDynamicFormData();
    data.connectingChannelId = selectedConnectingChannel?.channelId;
    data.connectingChannelName = selectedConnectingChannel?.channelName;
    data.connectingStatusId = selectedConnectingStatus?.statusId;
    data.connectingStatusName = selectedConnectingStatus?.statusName;
    data.connectingReasonId = selectedConnectingReason?.id;
    data.connectingReasonName = selectedConnectingReason?.reason;
    data.connectingReasonType = selectedConnectingReason?.type;
    data.callStatusId = selectedCallStatus?.callResultIdNew;
    data.callStatusName = selectedCallStatus?.callResultNew;
    data.leadStatus = leadStatus;

    data.rejectionCategoryIds = selectedRejectionCategoryIds.toList();
    Map<String, String> catReasons = {};
    for (var catId in selectedRejectionCategoryIds) {
      catReasons[catId] = rejectionReasonControllers[catId]?.text ?? '';
    }
    data.rejectionCategoryReasons = catReasons;
    data.callStatusReasonId = selectedRejectionCategoryIds.join(',');

    List<String> selectedReasonNames = [];
    if (callStatusReasonModel?.data != null) {
      for (var r in callStatusReasonModel!.data!) {
        if (selectedRejectionCategoryIds.contains(r.id)) {
          selectedReasonNames.add(r.reason ?? '');
        }
      }
    }
    data.callStatusReasonName = selectedReasonNames.join(',');

    data.triedToReduceRejection = triedToReduceRejection;
    data.reduceRejectionMethodIds = selectedReduceRejectionMethodIds.toList();
    data.reductionChallenges = reductionChallengesController.text;

    data.rejectionToRelation = rejectionToRelation;
    data.relationActionIds = selectedRelationActionIds.toList();
    data.relationChallenges = relationChallengesController.text;

    data.prospectQualified = prospectQualified;
    data.prospectParameterIds = selectedProspectParameterIds.toList();
    data.sharedPurpose = sharedProspectPurposeController.text;
    data.sharedPainPoint = sharedProspectPainPointController.text;
    data.prospectChallenges = prospectChallengesController.text;

    data.productCustomization = productCustomization;
    data.customizationParameterIds = selectedCustomizationParameterIds.toList();
    data.customizationChallenges = customizationChallengesController.text;

    data.customerSummary = customerSummaryController.text;
    data.customerChallenges = customerChallengesController.text;
    data.customerRating = customerRating;

    data.relationshipBuild = relationshipBuild;
    data.relationshipParameterIds = selectedRelationshipParameterIds.toList();
    data.relationshipChallenges = relationshipChallengesController.text;

    return data;
  }

  Future<void> _loadInitialData() async {
    await Future.wait([
      _fetchConnectingChannels(),
      _fetchConnectingStatuses(),
    ]);

    if (widget.initialChannelId != null && connectingChannelModel?.data != null) {
      for (var item in connectingChannelModel!.data!) {
        if (item.channelId == widget.initialChannelId) {
          selectedConnectingChannel = item;
          break;
        }
      }
    }

    if (widget.initialStatusId != null && connectingStatusModel?.data != null) {
      for (var item in connectingStatusModel!.data!) {
        if (item.statusId == widget.initialStatusId) {
          selectedConnectingStatus = item;
          break;
        }
      }

      if (selectedConnectingStatus != null) {
        await _fetchConnectingReasons(
          selectedConnectingStatus!.statusId!,
          selectedConnectingStatus!.statusName!,
        );

        if (widget.initialReasonId != null && connectingReasonsModel?.data != null) {
          for (var reason in connectingReasonsModel!.data!) {
            if (reason.id == widget.initialReasonId) {
              selectedConnectingReason = reason;
              break;
            }
          }
        }

        var filteredCallStatuses = getFilteredCallStatusList();
        if (widget.initialCallStatusId != null) {
          for (var cs in filteredCallStatuses) {
            if (cs.callResultIdNew == widget.initialCallStatusId) {
              _onCallStatusChanged(cs);
              break;
            }
          }

          if (selectedCallStatus != null && widget.initialCallStatusReasonId != null) {
            await _fetchCallStatusReasons(selectedCallStatus!.callResultIdNew!);
            var initialIds = widget.initialCallStatusReasonId!.split(',');
            for (var id in initialIds) {
              String trimmedId = id.trim();
              if (trimmedId.isNotEmpty) {
                selectedRejectionCategoryIds.add(trimmedId);
                String initialReasonText = widget.initialRejectionCategoryReasons?[trimmedId] ?? '';
                rejectionReasonControllers[trimmedId] = TextEditingController(text: initialReasonText);
              }
            }
          }
        }
      }
    }

    if (widget.initialTriedToReduce != null) {
      triedToReduceRejection = widget.initialTriedToReduce;
      if (triedToReduceRejection == 'Yes') {
        await _fetchReduceRejectionMethods();
        if (widget.initialReduceMethods != null) {
          selectedReduceRejectionMethodIds = widget.initialReduceMethods!.toSet();
        }
      } else if (triedToReduceRejection == 'No' && widget.initialReductionChallenges != null) {
        reductionChallengesController.text = widget.initialReductionChallenges!;
      }
    }

    if (widget.initialRejectionToRelation != null) {
      rejectionToRelation = widget.initialRejectionToRelation;
      if (rejectionToRelation == 'Yes') {
        await _fetchRejectionRelationActions();
        if (widget.initialRelationActions != null) {
          selectedRelationActionIds = widget.initialRelationActions!.toSet();
        }
      } else if (rejectionToRelation == 'No' && widget.initialRelationChallenges != null) {
        relationChallengesController.text = widget.initialRelationChallenges!;
      }
    }

    if (widget.initialProspectQualified != null) {
      prospectQualified = widget.initialProspectQualified;
      if (prospectQualified == 'Yes') {
        await _fetchProspectParameters();
        if (widget.initialProspectParams != null) {
          for (var pId in widget.initialProspectParams!) {
            selectedProspectParameterIds.add(pId);
          }
          if (widget.initialProspectPurpose != null && widget.initialProspectPurpose!.isNotEmpty) {
            sharedProspectPurposeController.text = widget.initialProspectPurpose!;
          } else if (widget.initialProspectParamValues != null && widget.initialProspectParamValues!.isNotEmpty) {
            final firstEntry = widget.initialProspectParamValues!.values.first;
            sharedProspectPurposeController.text = firstEntry['purpose'] ?? '';
          }

          if (widget.initialProspectPainPoint != null && widget.initialProspectPainPoint!.isNotEmpty) {
            sharedProspectPainPointController.text = widget.initialProspectPainPoint!;
          } else if (widget.initialProspectParamValues != null && widget.initialProspectParamValues!.isNotEmpty) {
            final firstEntry = widget.initialProspectParamValues!.values.first;
            sharedProspectPainPointController.text = firstEntry['painPoint'] ?? '';
          }
        }
      } else if (prospectQualified == 'No' && widget.initialProspectChallenges != null) {
        prospectChallengesController.text = widget.initialProspectChallenges!;
      }
    }

    if (widget.initialProductCustomization != null) {
      productCustomization = widget.initialProductCustomization;
      if (productCustomization == 'Yes') {
        await _fetchProductCustomizationParameters();
        if (widget.initialCustomizationParams != null) {
          selectedCustomizationParameterIds = widget.initialCustomizationParams!.toSet();
        }
      } else if (productCustomization == 'No' && widget.initialCustomizationChallenges != null) {
        customizationChallengesController.text = widget.initialCustomizationChallenges!;
      }
    }

    if (widget.initialCustomerSummary != null) {
      customerSummaryController.text = widget.initialCustomerSummary!;
    }
    if (widget.initialCustomerChallenges != null) {
      customerChallengesController.text = widget.initialCustomerChallenges!;
    }
    if (widget.initialCustomerRating != null) {
      customerRating = widget.initialCustomerRating!;
    }

    if (widget.initialRelationshipBuild != null) {
      relationshipBuild = widget.initialRelationshipBuild;
      if (relationshipBuild == 'Yes') {
        await _fetchRelationshipParameters();
        if (widget.initialRelationshipParams != null) {
          selectedRelationshipParameterIds = widget.initialRelationshipParams!.toSet();
        }
      } else if (relationshipBuild == 'No' && widget.initialRelationshipChallenges != null) {
        relationshipChallengesController.text = widget.initialRelationshipChallenges!;
      }
    }

    if (mounted) setState(() {});
    _notifyParent();
  }

  Future<String> _getToken() async {
    if (widget.token.isNotEmpty) {
      return widget.token;
    }
    var storedToken = await Common.getSharedPref("token");
    return storedToken?.toString() ?? '';
  }

  Future<void> _fetchConnectingChannels() async {
    if (isLoadingChannel) return;
    setState(() { isLoadingChannel = true; });
    final token = await _getToken();
    var res = await HttpService.getConnectingChannel(token);
    if (mounted) {
      setState(() {
        isLoadingChannel = false;
        connectingChannelModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load connecting channels', Colors.red);
        }
      });
    }
  }

  Future<void> _fetchConnectingStatuses() async {
    if (isLoadingConnectingStatus) return;
    setState(() { isLoadingConnectingStatus = true; });
    final token = await _getToken();
    var res = await HttpService.getConnectingStatus(token);
    if (mounted) {
      setState(() {
        isLoadingConnectingStatus = false;
        connectingStatusModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load connecting statuses', Colors.red);
        }
      });
    }
  }

  Future<void> _fetchConnectingReasons(String statusId, String statusName) async {
    if (isLoadingConnectingReasons) return;
    setState(() { isLoadingConnectingReasons = true; });
    final token = await _getToken();
    var res = await HttpService.getConnectingReasons(token, statusId, statusName);
    if (mounted) {
      setState(() {
        isLoadingConnectingReasons = false;
        connectingReasonsModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load connecting reasons', Colors.red);
        }
      });
    }
  }

  Future<void> _fetchCallStatusReasons(String callResultId) async {
    if (isLoadingCallStatusReason) return;
    setState(() { isLoadingCallStatusReason = true; });
    final token = await _getToken();
    var res = await HttpService.getLeadResultReasons(token, callResultId);
    if (mounted) {
      setState(() {
        isLoadingCallStatusReason = false;
        callStatusReasonModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load call status reasons', Colors.red);
        }
      });
    }
  }

  Future<void> _fetchReduceRejectionMethods() async {
    if (isLoadingReduceRejection) return;
    setState(() { isLoadingReduceRejection = true; });
    final token = await _getToken();
    var res = await HttpService.getReduceRejectionMethod(token);
    if (mounted) {
      setState(() {
        isLoadingReduceRejection = false;
        reduceRejectionMethodModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load reduction methods', Colors.red);
        }
      });
    }
  }

  Future<void> _fetchRejectionRelationActions() async {
    if (isLoadingRelationAction) return;
    setState(() { isLoadingRelationAction = true; });
    final token = await _getToken();
    var res = await HttpService.getRejectionRelationAction(token);
    if (mounted) {
      setState(() {
        isLoadingRelationAction = false;
        rejectionRelationActionModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load relation actions', Colors.red);
        }
      });
    }
  }

  Future<void> _fetchProspectParameters() async {
    if (isLoadingProspectParams) return;
    setState(() { isLoadingProspectParams = true; });
    final token = await _getToken();
    var res = await HttpService.getProspectParameters(token);
    if (mounted) {
      setState(() {
        isLoadingProspectParams = false;
        prospectParametersModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load prospect parameters', Colors.red);
        }
      });
    }
  }

  Future<void> _fetchProductCustomizationParameters() async {
    if (isLoadingCustomizationParams) return;
    setState(() { isLoadingCustomizationParams = true; });
    final token = await _getToken();
    var res = await HttpService.getProductCustomizationParameter(token);
    if (mounted) {
      setState(() {
        isLoadingCustomizationParams = false;
        productCustomizationParameterModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load customization parameters', Colors.red);
        }
      });
    }
  }

  Future<void> _fetchRelationshipParameters() async {
    if (isLoadingRelationshipParams) return;
    setState(() { isLoadingRelationshipParams = true; });
    final token = await _getToken();
    var res = await HttpService.getRelationshipParameters(token);
    if (mounted) {
      setState(() {
        isLoadingRelationshipParams = false;
        relationshipParameterModel = res;
        if (res == null || res.status == false) {
          Common.toastMessaage(res?.message ?? 'Failed to load relationship parameters', Colors.red);
        }
      });
    }
  }

  void _onConnectingStatusChanged(ConnectingStatusData? newStatus) {
    if (newStatus == null) return;
    setState(() {
      selectedConnectingStatus = newStatus;
      selectedConnectingReason = null;
      connectingReasonsModel = null;
      selectedCallStatus = null;
      leadStatus = null;
      callStatusReasonModel = null;
      _resetAllRejectionFields();
    });
    _notifyParent();

    if (newStatus.statusId != null && newStatus.statusName != null) {
      _fetchConnectingReasons(newStatus.statusId!, newStatus.statusName!);
    }
  }

  void _onConnectingReasonChanged(ConnectingReasonData? newReason) {
    if (newReason == null) return;
    setState(() {
      selectedConnectingReason = newReason;
      selectedCallStatus = null;
      leadStatus = null;
      callStatusReasonModel = null;
      _resetAllRejectionFields();
    });
    _notifyParent();
  }

  bool get _showRejectionFlow {
    if (selectedCallStatus == null) return false;
    final callStatusType = (selectedCallStatus?.type ?? '').trim().toLowerCase();
    final callStatusName = (selectedCallStatus?.callResultNew ?? '').trim().toLowerCase();
    final isRejectedOrCancel = callStatusType == 'cancel' || callStatusName == 'rejected';
    final hasReasons = callStatusReasonModel?.data != null && callStatusReasonModel!.data!.isNotEmpty;
    return isRejectedOrCancel && hasReasons;
  }

  void _onCallStatusChanged(CallResultNew? newCallStatus) {
    if (newCallStatus == null) return;
    setState(() {
      selectedCallStatus = newCallStatus;

      final type = (newCallStatus.type ?? '').trim().toLowerCase();
      if (type == 'active') {
        leadStatus = 'Active';
      } else if (type == 'cancel') {
        leadStatus = 'Cancel';
      } else {
        leadStatus = null;
      }

      callStatusReasonModel = null;
      _resetAllRejectionFields();

      if (newCallStatus.callResultIdNew != null) {
        _fetchCallStatusReasons(newCallStatus.callResultIdNew!);
      }
    });
    _notifyParent();
  }

  void _resetAllRejectionFields() {
    selectedRejectionCategoryIds.clear();
    for (var ctrl in rejectionReasonControllers.values) {
      ctrl.dispose();
    }
    rejectionReasonControllers.clear();

    triedToReduceRejection = null;
    reduceRejectionMethodModel = null;
    selectedReduceRejectionMethodIds.clear();
    reductionChallengesController.clear();

    rejectionToRelation = null;
    rejectionRelationActionModel = null;
    selectedRelationActionIds.clear();
    relationChallengesController.clear();

    prospectQualified = null;
    prospectParametersModel = null;
    selectedProspectParameterIds.clear();
    sharedProspectPurposeController.clear();
    sharedProspectPainPointController.clear();
    prospectChallengesController.clear();

    productCustomization = null;
    productCustomizationParameterModel = null;
    selectedCustomizationParameterIds.clear();
    customizationChallengesController.clear();

    relationshipBuild = null;
    relationshipParameterModel = null;
    selectedRelationshipParameterIds.clear();
    relationshipChallengesController.clear();
  }

  List<CallResultNew> getFilteredCallStatusList() {
    if (widget.commonDetails?.data?.callResultNew == null) return [];
    if (selectedConnectingStatus == null) return [];

    if (selectedConnectingReason != null) {
      final reasonType = (selectedConnectingReason!.type ?? '').trim().toLowerCase();
      if (reasonType.isNotEmpty) {
        return widget.commonDetails!.data!.callResultNew!.where((status) {
          final statusType = (status.type ?? '').trim().toLowerCase();
          return statusType.isNotEmpty && statusType == reasonType;
        }).toList();
      }
    }

    return widget.commonDetails!.data!.callResultNew!;
  }

  bool validate() {
    if (selectedConnectingChannel == null || selectedConnectingChannel!.channelId == null) {
      Common.toastMessaage('Please select Not Connecting Channel', Colors.red);
      return false;
    }
    if (selectedConnectingStatus == null || selectedConnectingStatus!.statusId == null) {
      Common.toastMessaage('Please select Connecting Status', Colors.red);
      return false;
    }
    if (_hasConnectingReasons) {
      if (selectedConnectingReason == null || selectedConnectingReason!.id == null) {
        Common.toastMessaage('Please select Not Connecting Reason', Colors.red);
        return false;
      }
    }
    if (selectedCallStatus == null || selectedCallStatus!.callResultIdNew == null) {
      Common.toastMessaage('Please select Call Status', Colors.red);
      return false;
    }
    if (leadStatus == null || leadStatus!.isEmpty) {
      Common.toastMessaage('Lead Status * is required', Colors.red);
      return false;
    }

    if (_showRejectionFlow) {
      if (selectedRejectionCategoryIds.isEmpty) {
        Common.toastMessaage('Please select at least one Rejection Category *', Colors.red);
        return false;
      }
      for (String catId in selectedRejectionCategoryIds) {
        var reasonCtrl = rejectionReasonControllers[catId];
        if (reasonCtrl == null || reasonCtrl.text.trim().isEmpty) {
          Common.toastMessaage('Reason for Interest * is required for selected category', Colors.red);
          return false;
        }
      }

      if (triedToReduceRejection == null) {
        Common.toastMessaage('Please select Tried to reduce the rejection *', Colors.red);
        return false;
      } else if (triedToReduceRejection == 'Yes') {
        if (selectedReduceRejectionMethodIds.isEmpty) {
          Common.toastMessaage('Please select at least one Reduction Method', Colors.red);
          return false;
        }
      } else if (triedToReduceRejection == 'No') {
        if (reductionChallengesController.text.trim().isEmpty) {
          Common.toastMessaage('Challenges You Have Faced * is required', Colors.red);
          return false;
        }
      }

      if (rejectionToRelation == null) {
        Common.toastMessaage('Please select Rejection to Relation *', Colors.red);
        return false;
      } else if (rejectionToRelation == 'Yes') {
        if (selectedRelationActionIds.isEmpty) {
          Common.toastMessaage('Please select at least one Relation Action', Colors.red);
          return false;
        }
      } else if (rejectionToRelation == 'No') {
        if (relationChallengesController.text.trim().isEmpty) {
          Common.toastMessaage('Challenges You Have Faced * is required', Colors.red);
          return false;
        }
      }
    }

    if (prospectQualified == null) {
      Common.toastMessaage('Please select Prospect Qualified *', Colors.red);
      return false;
    } else if (prospectQualified == 'No') {
      if (prospectChallengesController.text.trim().isEmpty) {
        Common.toastMessaage('Challenges Faced * is required', Colors.red);
        return false;
      }
    } else if (prospectQualified == 'Yes') {
      if (selectedProspectParameterIds.isEmpty) {
        Common.toastMessaage('Please select at least one Prospect Parameter', Colors.red);
        return false;
      }
      if (_isNeedProspectParamSelected) {
        if (sharedProspectPurposeController.text.trim().isEmpty) {
          Common.toastMessaage('Purpose * is required', Colors.red);
          return false;
        }
        if (sharedProspectPainPointController.text.trim().isEmpty) {
          Common.toastMessaage('Pain Point * is required', Colors.red);
          return false;
        }
      }
    }

    if (selectedCallStatus?.callResultIdNew == '2') {
      if (customerSummaryController.text.trim().isEmpty) {
        Common.toastMessaage('Customer Summary * is required', Colors.red);
        return false;
      }
      if (customerChallengesController.text.trim().isEmpty) {
        Common.toastMessaage('What Are Your Challenges * is required', Colors.red);
        return false;
      }
      if (customerRating == 0) {
        Common.toastMessaage('Customer Rating * is required', Colors.red);
        return false;
      }
    }

    if (productCustomization == null) {
      Common.toastMessaage('Please select Product Customization *', Colors.red);
      return false;
    } else if (productCustomization == 'No') {
      if (customizationChallengesController.text.trim().isEmpty) {
        Common.toastMessaage('Challenges Faced * is required', Colors.red);
        return false;
      }
    } else if (productCustomization == 'Yes') {
      if (selectedCustomizationParameterIds.isEmpty) {
        Common.toastMessaage('Please select at least one Customization Parameter', Colors.red);
        return false;
      }
    }

    if (relationshipBuild == null) {
      Common.toastMessaage('Please select Relationship Build *', Colors.red);
      return false;
    }
    if (relationshipBuild == 'Yes' && selectedRelationshipParameterIds.isEmpty) {
      Common.toastMessaage('Please select at least one Relationship Parameter', Colors.red);
      return false;
    } else if (relationshipBuild == 'No' && relationshipChallengesController.text.trim().isEmpty) {
      Common.toastMessaage('Challenges Faced * is required', Colors.red);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Connecting Channel Field
        _buildDropdownField(
          label: 'Connecting Channel *',
          value: selectedConnectingChannel?.channelName ?? 'Select Connecting Channel',
          isLoading: isLoadingChannel,
          onTap: () {
            if (isLoadingChannel) return;
            _showOptionsDialog<ConnectingChannelData>(
              title: 'Connecting Channel',
              items: connectingChannelModel?.data ?? [],
              itemLabel: (item) => item.channelName ?? '',
              onSelect: (item) {
                setState(() {
                  selectedConnectingChannel = item;
                });
                _notifyParent();
              },
            );
          },
        ),
        const SizedBox(height: 15),

        // 2. Connecting Status Field
        _buildDropdownField(
          label: 'Connecting Status *',
          value: selectedConnectingStatus?.statusName ?? 'Select Connecting Status',
          isLoading: isLoadingConnectingStatus,
          onTap: () {
            if (isLoadingConnectingStatus) return;
            _showOptionsDialog<ConnectingStatusData>(
              title: 'Connecting Status',
              items: connectingStatusModel?.data ?? [],
              itemLabel: (item) => item.statusName ?? '',
              onSelect: (item) => _onConnectingStatusChanged(item),
            );
          },
        ),
        const SizedBox(height: 15),

        // 3. Connecting Reason Field (shown ONLY if reasons exist for selected connecting status)
        if (selectedConnectingStatus != null &&
            (isLoadingConnectingReasons || _hasConnectingReasons)) ...[
          _buildDropdownField(
            label: 'Not Connecting Reason *',
            value: selectedConnectingReason?.reason ?? 'Select Not Connecting Reason',
            isLoading: isLoadingConnectingReasons,
            onTap: () {
              if (isLoadingConnectingReasons) return;
              _showOptionsDialog<ConnectingReasonData>(
                title: 'Connecting Reason',
                items: connectingReasonsModel?.data ?? [],
                itemLabel: (item) => item.reason ?? '',
                onSelect: (item) => _onConnectingReasonChanged(item),
              );
            },
          ),
          const SizedBox(height: 15),
        ],

        // 4. Call Status Field
        _buildDropdownField(
          label: 'Call Status *',
          value: selectedCallStatus?.callResultNew ??
              (!_canSelectCallStatus
                  ? (selectedConnectingStatus == null
                      ? 'Select Connecting Status First'
                      : 'Select Connecting Reason First')
                  : 'Select Call Status'),
          enabled: _canSelectCallStatus,
          onTap: () {
            if (!_canSelectCallStatus) return;
            var filteredList = getFilteredCallStatusList();
            _showOptionsDialog<CallResultNew>(
              title: 'Call Status',
              items: filteredList,
              itemLabel: (item) => item.callResultNew ?? '',
              onSelect: (item) => _onCallStatusChanged(item),
            );
          },
        ),
        const SizedBox(height: 15),

        // 5. Lead Status & Rejection Flow
        if (selectedCallStatus != null) ...[
          _buildRadioSection(
            title: 'Lead Status *',
            value: leadStatus,
            options: const ['Active', 'Cancel'],
            onChanged: null, // Auto-selected by call status type
          ),
          const SizedBox(height: 15),

          if (_showRejectionFlow) ...[
            // Rejection Category Checkboxes with Reasons for Interest
            _buildRejectionCategorySection(),
            const SizedBox(height: 20),

            // Tried to Reduce Rejection Section
            _buildRadioSection(
              title: 'Tried to reduce the rejection *',
              value: triedToReduceRejection,
              onChanged: (val) {
                setState(() {
                  triedToReduceRejection = val;
                  if (val == 'Yes') {
                    reductionChallengesController.clear();
                    _fetchReduceRejectionMethods();
                  } else {
                    selectedReduceRejectionMethodIds.clear();
                  }
                });
                _notifyParent();
              },
            ),
            if (triedToReduceRejection == 'Yes') ...[
              const SizedBox(height: 10),
              _buildCheckboxList<ReduceRejectionMethodData>(
                title: 'Reduction Methods *',
                isLoading: isLoadingReduceRejection,
                items: reduceRejectionMethodModel?.data ?? [],
                itemId: (item) => item.id ?? '',
                itemLabel: (item) => item.methodName ?? '',
                selectedIds: selectedReduceRejectionMethodIds,
                onToggle: (id, checked) {
                  setState(() {
                    if (checked) {
                      selectedReduceRejectionMethodIds.add(id);
                    } else {
                      selectedReduceRejectionMethodIds.remove(id);
                    }
                  });
                  _notifyParent();
                },
              ),
            ] else if (triedToReduceRejection == 'No') ...[
              const SizedBox(height: 10),
              _buildTextAreaField(
                label: 'Challenges You Have Faced *',
                controller: reductionChallengesController,
                hintText: 'Enter challenges faced',
              ),
            ],
            const SizedBox(height: 20),

            // Rejection to Relation Section
            _buildRadioSection(
              title: 'Rejection to Relation *',
              value: rejectionToRelation,
              onChanged: (val) {
                setState(() {
                  rejectionToRelation = val;
                  if (val == 'Yes') {
                    relationChallengesController.clear();
                    _fetchRejectionRelationActions();
                  } else {
                    selectedRelationActionIds.clear();
                  }
                });
                _notifyParent();
              },
            ),
            if (rejectionToRelation == 'Yes') ...[
              const SizedBox(height: 10),
              _buildCheckboxList<RejectionRelationActionData>(
                title: 'Relation Actions *',
                isLoading: isLoadingRelationAction,
                items: rejectionRelationActionModel?.data ?? [],
                itemId: (item) => item.id ?? '',
                itemLabel: (item) => item.actionName ?? '',
                selectedIds: selectedRelationActionIds,
                onToggle: (id, checked) {
                  setState(() {
                    if (checked) {
                      selectedRelationActionIds.add(id);
                    } else {
                      selectedRelationActionIds.remove(id);
                    }
                  });
                  _notifyParent();
                },
              ),
            ] else if (rejectionToRelation == 'No') ...[
              const SizedBox(height: 10),
              _buildTextAreaField(
                label: 'Challenges You Have Faced *',
                controller: relationChallengesController,
                hintText: 'Enter challenges faced',
              ),
            ],
            const SizedBox(height: 20),
          ],
        ],

        // Customer Summary, Challenges, Rating (only displayed under same condition as Reschedule Date & Time, i.e. callResultId == '2')
        if (selectedCallStatus?.callResultIdNew == '2') ...[
          _buildTextAreaField(
            label: 'Customer Summary *',
            controller: customerSummaryController,
            hintText: 'Enter customer summary',
          ),
          const SizedBox(height: 15),
          _buildTextAreaField(
            label: 'What Are Your Challenges *',
            controller: customerChallengesController,
            hintText: 'Enter challenges',
          ),
          const SizedBox(height: 15),
          _buildStarRating(),
          const SizedBox(height: 20),
        ],

        // Prospect Qualified Section
        _buildRadioSection(
          title: 'Prospect Qualified *',
          value: prospectQualified,
          onChanged: (val) {
            setState(() {
              prospectQualified = val;
              if (val == 'Yes') {
                prospectChallengesController.clear();
                sharedProspectPurposeController.clear();
                sharedProspectPainPointController.clear();
                selectedProspectParameterIds.clear();
                _fetchProspectParameters();
              } else {
                selectedProspectParameterIds.clear();
                sharedProspectPurposeController.clear();
                sharedProspectPainPointController.clear();
              }
            });
            _notifyParent();
          },
        ),
        if (prospectQualified == 'Yes') ...[
          const SizedBox(height: 10),
          _buildProspectParametersList(),
        ] else if (prospectQualified == 'No') ...[
          const SizedBox(height: 10),
          _buildTextAreaField(
            label: 'Challenges Faced *',
            controller: prospectChallengesController,
            hintText: 'Enter challenges faced',
          ),
        ],
        const SizedBox(height: 20),

        // Product Customization Section
        _buildRadioSection(
          title: 'Product Customization *',
          value: productCustomization,
          onChanged: (val) {
            setState(() {
              productCustomization = val;
              if (val == 'Yes') {
                customizationChallengesController.clear();
                _fetchProductCustomizationParameters();
              } else {
                selectedCustomizationParameterIds.clear();
              }
            });
            _notifyParent();
          },
        ),
        if (productCustomization == 'Yes') ...[
          const SizedBox(height: 10),
          _buildCheckboxList<ProductCustomizationParameterData>(
            title: 'Customization Parameters *',
            isLoading: isLoadingCustomizationParams,
            items: productCustomizationParameterModel?.data ?? [],
            itemId: (item) => item.id ?? '',
            itemLabel: (item) => item.parameterName ?? '',
            selectedIds: selectedCustomizationParameterIds,
            onToggle: (id, checked) {
              setState(() {
                if (checked) {
                  selectedCustomizationParameterIds.add(id);
                } else {
                  selectedCustomizationParameterIds.remove(id);
                }
              });
              _notifyParent();
            },
          ),
        ] else if (productCustomization == 'No') ...[
          const SizedBox(height: 10),
          _buildTextAreaField(
            label: 'Challenges Faced *',
            controller: customizationChallengesController,
            hintText: 'Enter challenges faced',
          ),
        ],
        const SizedBox(height: 10),

        // Relationship Build Section
        _buildRadioSection(
          title: 'Relationship Build *',
          value: relationshipBuild,
          onChanged: (val) {
            setState(() {
              relationshipBuild = val;
              if (val == 'Yes') {
                relationshipChallengesController.clear();
                selectedRelationshipParameterIds.clear();
                _fetchRelationshipParameters();
              } else {
                selectedRelationshipParameterIds.clear();
                relationshipParameterModel = null;
              }
            });
            _notifyParent();
          },
        ),
        if (relationshipBuild == 'Yes') ...[
          const SizedBox(height: 10),
          _buildCheckboxList<RelationshipParameterData>(
            title: 'Relationship Parameters *',
            isLoading: isLoadingRelationshipParams,
            items: relationshipParameterModel?.data ?? [],
            itemId: (item) => item.parameterId ?? '',
            itemLabel: (item) => item.parameterName ?? '',
            selectedIds: selectedRelationshipParameterIds,
            onToggle: (id, checked) {
              setState(() {
                if (checked) {
                  selectedRelationshipParameterIds.add(id);
                } else {
                  selectedRelationshipParameterIds.remove(id);
                }
              });
              _notifyParent();
            },
          ),
        ] else if (relationshipBuild == 'No') ...[
          const SizedBox(height: 10),
          _buildTextAreaField(
            label: 'Challenges Faced *',
            controller: relationshipChallengesController,
            hintText: 'Enter challenges faced',
          ),
        ],
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required VoidCallback onTap,
    bool isLoading = false,
    bool enabled = true,
  }) {
    bool isSelected = value.isNotEmpty &&
        !value.startsWith('Select') &&
        !value.startsWith('Choose');
    bool isFieldEnabled = enabled && !widget.isReadOnly;

    return InkWell(
      onTap: isFieldEnabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isFieldEnabled ? Colors.white : Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      color: isFieldEnabled && isSelected ? Colors.black87 : Colors.grey,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isLoading)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (isFieldEnabled)
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black54,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioSection({
    required String title,
    required String? value,
    required Function(String val)? onChanged,
    List<String> options = const ['Yes', 'No'],
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: widget.isReadOnly ? Colors.grey.shade100 : Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: options.map((opt) {
              return Row(
                children: [
                  Radio<String>(
                    value: opt,
                    groupValue: value,
                    onChanged: widget.isReadOnly
                        ? null
                        : (onChanged != null
                            ? (val) {
                                if (val != null) onChanged(val);
                              }
                            : null),
                  ),
                  Text(opt),
                  const SizedBox(width: 30),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextAreaField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: widget.isReadOnly,
      onChanged: (_) => _notifyParent(),
      maxLines: 3,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.all(12),
        fillColor: widget.isReadOnly ? Colors.grey.shade100 : Colors.white,
        filled: true,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildCheckboxList<T>({
    required String title,
    required bool isLoading,
    required List<T> items,
    required String Function(T item) itemId,
    required String Function(T item) itemLabel,
    required Set<String> selectedIds,
    required Function(String id, bool checked) onToggle,
  }) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        child: const Text(
          'No options available',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.isReadOnly ? Colors.grey.shade100 : Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          ...items.map((item) {
            String id = itemId(item);
            String label = itemLabel(item);
            bool isChecked = selectedIds.contains(id);
            return CheckboxListTile(
              dense: true,
              title: Text(label),
              value: isChecked,
              onChanged: widget.isReadOnly
                  ? null
                  : (bool? val) {
                      if (val != null) {
                        onToggle(id, val);
                      }
                    },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRejectionCategorySection() {
    if (isLoadingCallStatusReason) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    var items = callStatusReasonModel?.data ?? [];
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        child: const Text('No rejection categories available', style: TextStyle(color: Colors.red)),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.isReadOnly ? Colors.grey.shade100 : Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
            child: Text(
              'Rejection Category *',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          ...items.map((cat) {
            String id = cat.id ?? '';
            String label = cat.reason ?? '';
            bool isChecked = selectedRejectionCategoryIds.contains(id);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  dense: true,
                  title: Text(label),
                  value: isChecked,
                  onChanged: widget.isReadOnly
                      ? null
                      : (bool? val) {
                          setState(() {
                            if (val == true) {
                              selectedRejectionCategoryIds.add(id);
                              rejectionReasonControllers[id] = TextEditingController();
                            } else {
                              selectedRejectionCategoryIds.remove(id);
                              rejectionReasonControllers[id]?.dispose();
                              rejectionReasonControllers.remove(id);
                            }
                          });
                          _notifyParent();
                        },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                if (isChecked)
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 16, bottom: 12),
                    child: TextFormField(
                      controller: rejectionReasonControllers[id],
                      readOnly: widget.isReadOnly,
                      onChanged: widget.isReadOnly ? null : (_) => _notifyParent(),
                      decoration: InputDecoration(
                        labelText: 'Reason for Interest *',
                        hintText: 'Reason for $label',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        fillColor: widget.isReadOnly ? Colors.grey.shade100 : Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProspectParametersList() {
    if (isLoadingProspectParams) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    var items = prospectParametersModel?.data ?? [];
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        child: const Text('No prospect parameters available', style: TextStyle(color: Colors.red)),
      );
    }

    final bool anyChecked = selectedProspectParameterIds.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
            child: Text(
              'Prospect Parameters *',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          // Checkboxes — one per parameter
          ...items.map((param) {
            String id = param.parameterId ?? '';
            String label = param.parameterName ?? '';
            bool isChecked = selectedProspectParameterIds.contains(id);

            return CheckboxListTile(
              dense: true,
              title: Text(label),
              value: isChecked,
              onChanged: widget.isReadOnly
                  ? null
                  : (bool? val) {
                      setState(() {
                        if (val == true) {
                          selectedProspectParameterIds.add(id);
                        } else {
                          selectedProspectParameterIds.remove(id);
                          final labelName = label.trim().toLowerCase();
                          if (labelName == 'need' || selectedProspectParameterIds.isEmpty) {
                            sharedProspectPurposeController.clear();
                            sharedProspectPainPointController.clear();
                          }
                        }
                      });
                      _notifyParent();
                    },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
          // Shared Purpose & Pain Point — shown ONLY when 'Need' parameter checkbox is checked
          if (_isNeedProspectParamSelected) ...[
            const Divider(),
            const SizedBox(height: 8),
            TextFormField(
              controller: sharedProspectPurposeController,
              readOnly: widget.isReadOnly,
              onChanged: widget.isReadOnly ? null : (_) => _notifyParent(),
              decoration: InputDecoration(
                labelText: 'Purpose *',
                hintText: 'Enter purpose',
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                fillColor: widget.isReadOnly ? Colors.grey.shade100 : Colors.white,
                filled: true,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: sharedProspectPainPointController,
              readOnly: widget.isReadOnly,
              onChanged: widget.isReadOnly ? null : (_) => _notifyParent(),
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Pain Point *',
                hintText: 'Enter pain point',
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                fillColor: widget.isReadOnly ? Colors.grey.shade100 : Colors.white,
                filled: true,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer Rating (out of 10) *',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(10, (index) {
              final star = index + 1;
              return GestureDetector(
                onTap: widget.isReadOnly
                    ? null
                    : () {
                        setState(() {
                          customerRating = star;
                        });
                        _notifyParent();
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    star <= customerRating ? Icons.star : Icons.star_border,
                    color: star <= customerRating ? Colors.amber : Colors.grey.shade400,
                    size: 28,
                  ),
                ),
              );
            }),
          ),
          if (customerRating > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '$customerRating / 10',
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
        ],
      ),
    );
  }

  void _showOptionsDialog<T>({
    required String title,
    required List<T> items,
    required String Function(T item) itemLabel,
    required Function(T item) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              items.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No options available'),
                    )
                  : Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          T item = items[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              onSelect(item);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(
                                itemLabel(item),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
