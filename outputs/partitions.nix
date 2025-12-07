{ chadLib, ... }:
chadLib.enum.create {
  mappings = {
    extraInputsFlakePath = {
      development = ./development;
      public = ./public;
    };

    flakeOutputAttributeNames = {
      development = [
        "checks"
        "devShells"
        "formatter"
        "legacyPackages"
        "packages"
        "tests"
      ];

      public = [
        "lib"
        "templates"
      ];
    };

    modulePath = {
      development = ./development/modules;
      public = ./public/modules;
    };

    name = {
      development = "development";
      public = "public";
    };
  };

  memberNames = [
    "development"
    "public"
  ];

  name = "partitions";
}
