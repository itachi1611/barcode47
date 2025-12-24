enum Routers {
  root('/', '/'),
  login('/login', 'login'),
  forgotPassword('/forgotPassword', 'forgotPassword'),
  profile('/profile', 'profile'),
  home('/home', 'home'),
  view('/view', 'view'),
  setting('/setting', 'setting');

  final String routerName;
  final String routerPath;

  const Routers(this.routerPath, this.routerName);
}
