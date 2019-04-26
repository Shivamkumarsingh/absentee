class User{
  String id;
  String name;
  String username;
  String email;
  String api_key;
  String role_code;
  String auth_Token;
  bool active;
  Company company;
  List<Site> sites;
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.api_key,
    this.role_code,
    this.auth_Token,
    this.active,
    this.company,
    this.sites
  });
  factory User.fromJson(Map<String, dynamic> parsedJson){
    var sites = parsedJson["sites"];
    return User(
        id: parsedJson['id'],
        name : parsedJson['name'],
        username : parsedJson ['username'],
        email: parsedJson['email'],
        api_key : parsedJson['api_key'],
        role_code : parsedJson ['role_code'],
        auth_Token: parsedJson['auth_token'],
        active : parsedJson['active'],
        company :Company.fromJson(parsedJson),
        sites:  (sites as List)
            .map((data) => new Site.fromJson(data))
            .toList()
    );
  }

}
class Company{
  String subdomain;
  String name;
  Company({
    this.subdomain,
    this.name
  });
  factory Company.fromJson(Map<String, dynamic> parsedJson){
    var company = parsedJson["company"];
    return Company(

        name: company['name'],
        subdomain : company['subdomain']
    );
  }
}
class Site{
  String id;
  String currency;
  String name;
  String logo_url;
  Site({
    this.id,
    this.name,
    this.currency,
    this.logo_url
  });
  factory Site.fromJson(Map<String, dynamic> parsedJson){
   // var sites = parsedJson["sites"];
  //  var site = sites[0];
    return Site(
        currency: parsedJson['currency'],
        name: parsedJson['name'],
        id : parsedJson['id'],
        logo_url: parsedJson["logo_url"]
    );
  }
}