{
  directions,
  foldIntegersBetween1And9IntoAttrs,
  keys,
  modes,
  searchOptions,
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
      ${keys.bind [ "Ctrl a" ]} = {
        ${keys.switchToMode modes.members.pane} = { };
      };
      ${keys.bind [ "Ctrl s" ]} = {
        ${keys.switchToMode modes.members.scroll} = { };
      };
      ${keys.bind [ "Ctrl t" ]} = {
        ${keys.switchToMode modes.members.tab} = { };
      };
    };
    ${keys.pane} = {
      ${keys.bind [ "f" ]} = {
        ${keys.toggleFocusFullScreen} = { };
        ${keys.switchToMode modes.members.normal} = { };
      };
      ${keys.bind [ "h" ]} = {
        ${keys.moveFocusOrTab directions.members.left} = { };
      };
      ${keys.bind [ "j" ]} = {
        ${keys.moveFocusOrTab directions.members.down} = { };
      };
      ${keys.bind [ "k" ]} = {
        ${keys.moveFocusOrTab directions.members.up} = { };
      };
      ${keys.bind [ "l" ]} = {
        ${keys.moveFocusOrTab directions.members.right} = { };
      };
      ${keys.bind [ "n" ]} = {
        ${keys.newPane} = { };
        ${keys.switchToMode modes.members.normal} = { };
      };
      ${keys.bind [ "x" ]} = {
        ${keys.closeFocus} = { };
        ${keys.switchToMode modes.members.normal} = { };
      };
      ${keys.bind [ "z" ]} = {
        ${keys.togglePaneFrames} = { };
        ${keys.switchToMode modes.members.normal} = { };
      };
    };
    ${keys.search} = {
      ${keys.bind [ "d" ]} = {
        ${keys.halfPageScrollDown} = { };
      };
      ${keys.bind [ "n" ]} = {
        ${keys.searchDown} = { };
      };
      ${keys.bind [ "p" ]} = {
        ${keys.searchUp} = { };
      };
      ${keys.bind [ "s" ]} = {
        ${keys.searchToggleOption searchOptions.members.caseSensitivity} = { };
      };
      ${keys.bind [ "u" ]} = {
        ${keys.halfPageScrollUp} = { };
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
      ${keys.bind [ "j" ]} = {
        ${keys.scrollDown} = { };
      };
      ${keys.bind [ "k" ]} = {
        ${keys.scrollUp} = { };
      };
      ${keys.bind [ "s" ]} = {
        ${keys.switchToMode modes.members.enterSearch} = { };
        # FIXME: this does not work with the default KDL renderer
        # as NIX does not preserve attrset entries order. Instead,
        # it orders them alphabetically.
        # ${keys.searchInput 0} = { };
      };
      ${keys.bind [ "u" ]} = {
        ${keys.halfPageScrollUp} = { };
      };
    };
    ${keys.sharedExcept (with modes.members; [ locked ])} = {
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
      keys.sharedExcept (
        with modes.members;
        [
          enterSearch
          locked
          normal
        ]
      )
    } =
      {
        ${keys.bind [ "Esc" ]} = {
          ${keys.switchToMode modes.members.normal} = { };
        };
      };
  };
}
