{ defaultGpgKey, ... }: {
  enable = true;
  settings = {
    no-auto-key-retrieve = true;
    no-comments = true;
    no-emit-version = true;
    default-key = defaultGpgKey;
  };
}
