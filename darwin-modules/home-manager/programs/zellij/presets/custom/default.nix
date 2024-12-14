{
  directions,
  foldIntegersBetween1And9IntoAttrs,
  keys,
  modes,
  ...
}:
{
  default_mode = modes.mapTo.key modes.members.normal;
  keybinds = {
    _props = {
      clear-defaults = true;
    };
    ${keys.enterSearch} = {
      ${keys.bind [ "Enter" ]} = {
        ${keys.switchToMode modes.members.search} = { };
      };
      ${keys.bind [ "Esc" ]} = {
        ${keys.switchToMode modes.members.scroll} = { };
      };
    };
    ${keys.normal} = {
      ${keys.bind [ "Ctrl s" ]} = {
        ${keys.switchToMode modes.members.scroll} = { };
      };
    };
    ${keys.tab} =
      {
        ${keys.bind [ "Tab" ]} = {
          ${keys.toggleTab} = { };
        };
        ${keys.bind [ "n" ]} = {
          ${keys.newTab} = { };
          ${keys.switchToMode modes.members.normal} = { };
        };
        ${keys.bind [ "x" ]} = {
          ${keys.closeTab} = { };
          ${keys.switchToMode modes.members.normal} = { };
        };
      }
      // foldIntegersBetween1And9IntoAttrs (i: {
        ${keys.bind [ (toString i) ]} = {
          ${keys.goToTab i} = { };
          ${keys.switchToMode modes.members.normal} = { };
        };
      });
    ${keys.scroll} = {
      ${keys.bind [ "d" ]} = {
        ${keys.halfPageScrollDown} = { };
      };
      ${keys.bind [ "s" ]} = {
        ${keys.switchToMode modes.members.enterSearch} = { };
        ${keys.searchInput 0} = { };
      };
      ${keys.bind [ "u" ]} = {
        ${keys.halfPageScrollUp} = { };
      };
    };
    ${keys.sharedExcept [ modes.members.locked ]} = {
      ${keys.bind [ "Alt h" ]} = {
        ${keys.moveFocusOrTab directions.members.left} = { };
      };
      ${keys.bind [ "Alt j" ]} = {
        ${keys.moveFocusOrTab directions.members.down} = { };
      };
      ${keys.bind [ "Alt k" ]} = {
        ${keys.moveFocusOrTab directions.members.up} = { };
      };
      ${keys.bind [ "Alt l" ]} = {
        ${keys.moveFocusOrTab directions.members.right} = { };
      };
      ${keys.bind [ "Alt z" ]} = {
        ${keys.togglePaneFrames} = { };
      };
    };
    ${
      keys.sharedExcept [
        modes.members.enterSearch
        modes.members.locked
        modes.members.normal
      ]
    } =
      {
        ${keys.bind [ "Esc" ]} = {
          ${keys.switchToMode modes.members.normal} = { };
        };
      };
    ${
      keys.sharedExcept [
        modes.members.locked
        modes.members.tab
      ]
    } =
      {
        ${keys.bind [ "Ctrl t" ]} = {
          ${keys.switchToMode modes.members.tab} = { };
        };
      };
  };
}
