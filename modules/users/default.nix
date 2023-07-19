{ username, ... }:
{
  users = {
    users."${username}" = {
      home = "/Users/${username}";
      name = "${username}";
    };
  };
}
