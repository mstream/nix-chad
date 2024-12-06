{ pkgs, yants, ... }:
let
  modes = import ./modes.nix { inherit yants; };
  keys = import ./keys.nix { inherit modes pkgs; };
  foldIntegersBetween1And9IntoAttrs =
    integerToSingleton:
    builtins.foldl' (acc: i: acc // integerToSingleton i) { } [
      1
      2
      3
      4
      5
      6
      7
      8
      9
    ];
in
{
  _props = {
    clear-defaults = true;
  };
  ${keys.enterSearch} = {
    ${keys.bind [ "Enter" ]} = { };
    ${keys.bind [ "Esc" ]} = { };
  };
  ${keys.tab} =
    {
      ${keys.bind [ "Tab" ]} = {
        ${keys.toggleTab} = { };
      };
      ${keys.bind [ "n" ]} = {
        ${keys.newTab} = { };
        ${keys.switchToMode modes.enums.normal} = { };
      };
      ${keys.bind [ "x" ]} = {
        ${keys.closeTab} = { };
        ${keys.switchToMode modes.enums.normal} = { };
      };
    }
    // foldIntegersBetween1And9IntoAttrs (i: {
      ${keys.bind [ (toString i) ]} = {
        ${keys.goToTab i} = { };
        ${keys.switchToMode modes.enums.normal} = { };
      };
    });
  search = {
    ${keys.bind [ "d" ]} = {
      ${keys.halfPageScrollDown} = { };
    };
    ${keys.bind [ "s" ]} = {
      ${keys.switchToMode modes.enums.enterSearch} = { };
      ${keys.searchInput 0} = { };
    };
    ${keys.bind [ "u" ]} = {
      ${keys.halfPageScrollUp} = { };
    };
  };
  ${keys.sharedExcept [ "locked" ]} = {
    ${keys.bind [ "Alt h" ]} = {
      ${keys.moveFocusOrTab "Left"} = { };
    };
    ${keys.bind [ "Alt j" ]} = {
      ${keys.moveFocusOrTab "Down"} = { };
    };
    ${keys.bind [ "Alt k" ]} = {
      ${keys.moveFocusOrTab "Up"} = { };
    };
    ${keys.bind [ "Alt l" ]} = {
      ${keys.moveFocusOrTab "Right"} = { };
    };
  };
  ${
    keys.sharedExcept [
      modes.enums.enterSearch
      modes.enums.locked
      modes.enums.normal
    ]
  } =
    {
      ${keys.bind [ "Esc" ]} = {
        ${keys.switchToMode modes.enums.normal} = { };
      };
    };
  ${
    keys.sharedExcept [
      modes.enums.locked
      modes.enums.search
    ]
  } =
    {
      ${keys.bind [ "Ctrl s" ]} = {
        ${keys.switchToMode modes.enums.search} = { };
      };
    };
  ${
    keys.sharedExcept [
      modes.enums.locked
      modes.enums.tab
    ]
  } =
    {
      ${keys.bind [ "Ctrl t" ]} = {
        ${keys.switchToMode modes.enums.tab} = { };
      };
    };
}
