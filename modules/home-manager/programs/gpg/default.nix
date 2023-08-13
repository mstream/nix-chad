{ defaultGpgKey, ... }: {
  enable = defaultGpgKey != null;
  settings = {
    no-auto-key-retrieve = true;
    no-comments = true;
    no-emit-version = true;
    default-key = defaultGpgKey;
  };
}
