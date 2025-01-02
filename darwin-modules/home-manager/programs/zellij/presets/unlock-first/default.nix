{
  directions,
  foldIntegersBetween1And9IntoAttrs,
  keys,
  modes,
  ...
}:
let
  primaryModifier = "Ctrl Super";
  secondaryModifier = "Alt Super";
in
{
  default_model = modes.mapTo.key modes.members.locked;
  keybinds = {
    _props = {
      clear-defaults = true;
    };
    ${keys.normal} = { };
    ${keys.locked} = {
      ${keys.bind [ "${primaryModifier} g" ]} = {
        ${keys.switchToMode modes.members.normal} = { };
      };
    };
    ${keys.tab} =
      {
        ${keys.bind [ "n" ]} = {
          ${keys.newTab} = { };
          ${keys.switchToMode modes.members.locked} = { };
        };
        ${keys.bind [ "x" ]} = {
          ${keys.closeTab} = { };
          ${keys.switchToMode modes.members.locked} = { };
        };

      }
      // foldIntegersBetween1And9IntoAttrs (i: {
        ${keys.bind [ (toString i) ]} = {
          ${keys.goToTab i} = { };
          ${keys.switchToMode modes.members.locked} = { };
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
    ${
      keys.sharedExcept [
        modes.members.enterSearch
        modes.members.locked
        modes.members.renamePane
        modes.members.renameTab
      ]
    } =
      {
        ${keys.bind [ "Esc" ]} = {
          ${keys.switchToMode modes.members.locked} = { };
        };
      };
    ${
      keys.sharedAmong [
        modes.members.locked
        modes.members.normal
      ]
    } =
      {
        ${keys.bind [ "${secondaryModifier} h" ]} = {
          ${keys.moveFocusOrTab directions.members.left} = { };
        };
        ${keys.bind [ "${secondaryModifier} j" ]} = {
          ${keys.moveFocusOrTab directions.members.down} = { };
        };
        ${keys.bind [ "${secondaryModifier} k" ]} = {
          ${keys.moveFocusOrTab directions.members.up} = { };
        };
        ${keys.bind [ "${secondaryModifier} l" ]} = {
          ${keys.moveFocusOrTab directions.members.right} = { };
        };
        ${keys.bind [ "${secondaryModifier} z" ]} = {
          ${keys.togglePaneFrames} = { };
        };
      };
    ${
      keys.sharedExcept [
        modes.members.enterSearch
        modes.members.locked
        modes.members.renamePane
        modes.members.renameTab
        modes.members.scroll
      ]
    } =
      {
        ${keys.bind [ "s" ]} = {
          ${keys.switchToMode modes.members.scroll} = { };
        };
      };
    ${
      keys.sharedExcept [
        modes.members.enterSearch
        modes.members.locked
        modes.members.renamePane
        modes.members.renameTab
        modes.members.tab
      ]
    } =
      {
        ${keys.bind [ "t" ]} = {
          ${keys.switchToMode modes.members.tab} = { };
        };
      };
  };
}
