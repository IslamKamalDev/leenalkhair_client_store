class CreateContractRequest {
  String? startDate;
  String? endDate;
  String? deliveryTimeId;
  String? deliveryDurationId;
  int? contractID;
  String? pricing_type_id;
  String? pricing_sub_type;
  String? pricing_sub_type_ar;

  CreateContractRequest(
      {this.deliveryDurationId,
      this.deliveryTimeId,
      this.endDate,
      this.contractID,
      this.startDate,
      this.pricing_type_id,
      this.pricing_sub_type,
      this.pricing_sub_type_ar});

  toMap() => {
        "start_date": startDate,
        "end_date": endDate,
        "delivery_timing_id": deliveryTimeId,
        "delivery_duration_id": deliveryDurationId,
        "contract_id": contractID,
        "pricing_type_id" : pricing_type_id,
    "pricing_sub_type" : pricing_sub_type,
    "pricing_sub_type_ar" : pricing_sub_type_ar

      };
}
