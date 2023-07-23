class ModelContent {
  String? rowId;
  String? webContentTitleTpCd;
  String? webContentTitleTpNm;
  String? webContentTitle;
  String? webContentImage;
  String? webContentUrl;
  String? webContentDate;
  String? webContentDescription;

  ModelContent(
      this.rowId,
      this.webContentTitleTpCd,
      this.webContentTitleTpNm,
      this.webContentTitle,
      this.webContentImage,
      this.webContentUrl,
      this.webContentDate,
      this.webContentDescription);

  factory ModelContent.fromJson(Map<String, dynamic> json) {
    return ModelContent(
      json["rowId"],
      json["webContentTittleTpCd"],
      json["webContentTittleTpNm"],
      json["webContentTittle"],
      json["webContentTittleImage"],
      json["webContentUrl"],
      json["webContentDate"],
      json["webContentDescription"],
    );
  }
}
