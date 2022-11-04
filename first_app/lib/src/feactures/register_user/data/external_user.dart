class ExternalUserDTO {
  final String name;
  final String external_user_id;
  final bool is_email_verified;
  final String? img;

  ExternalUserDTO(
      this.name, this.external_user_id, this.is_email_verified, this.img);

  Map<String, dynamic> toJson() => _extenalUserToJson(this);

  Map<String, dynamic> _extenalUserToJson(ExternalUserDTO instance) =>
      <String, dynamic>{
        'name': instance.name,
        'external_user_id': instance.external_user_id,
        'is_email_verified': instance.is_email_verified,
        'img': instance.img,
      };
}
