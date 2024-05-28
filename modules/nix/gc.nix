_: { 
  nix.gc = 
    { automatic = true; 
      interval = { 
        Minute = 30; 
      };
    }; 
}
