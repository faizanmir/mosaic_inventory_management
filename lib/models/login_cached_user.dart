class LoginCachedUser{
  String? email;
  String? password;

  LoginCachedUser(this.email, this.password);

  @override
  String toString() {
    return 'LoginCachedUser{email: $email, password: $password}';
  }
}