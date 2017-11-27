class my_notify {

  notify { 'foo': message => hiera('foo_message', 'Not Found'), }

}
