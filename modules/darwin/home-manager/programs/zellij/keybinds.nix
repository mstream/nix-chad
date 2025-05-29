{
  chadLib,
  directions,
  kms,
  keys,
  modes,
  searchOptions,
  ...
}:
let
  foldIntegersBetween1And9IntoAttrs = chadLib.attrsets.generate (
    chadLib.lists.range 1 9
  );
in
{
  _props = {
    clear-defaults = true;
  };
  ${keys.enterSearch} = with kms.modal.enterSearch.entries; {
    ${keys.bind [ switchToSearchMode ]} = {
      ${keys.switchToMode modes.members.search} = { };
    };
    ${keys.bind [ switchToScrollMode ]} = {
      ${keys.switchToMode modes.members.scroll} = { };
    };
  };
  ${keys.normal} = with kms.modal.normal.entries; {
    ${keys.bind [ switchToPaneMode ]} = {
      ${keys.switchToMode modes.members.pane} = { };
    };
    ${keys.bind [ switchToScrollMode ]} = {
      ${keys.switchToMode modes.members.scroll} = { };
    };
    ${keys.bind [ switchToTabMode ]} = {
      ${keys.switchToMode modes.members.tab} = { };
    };
  };
  ${keys.pane} = with kms.modal.pane.entries; {
    ${keys.bind [ toggleFullScreen ]} = {
      ${keys.toggleFocusFullScreen} = { };
      ${keys.switchToMode modes.members.normal} = { };
    };
    ${keys.bind [ moveFocusLeft ]} = {
      ${keys.moveFocus directions.members.left} = { };
    };
    ${keys.bind [ moveFocusDown ]} = {
      ${keys.moveFocus directions.members.down} = { };
    };
    ${keys.bind [ moveFocusUp ]} = {
      ${keys.moveFocus directions.members.up} = { };
    };
    ${keys.bind [ moveFocusRight ]} = {
      ${keys.moveFocus directions.members.right} = { };
    };
    ${keys.bind [ newPane ]} = {
      ${keys.newPane} = { };
      ${keys.switchToMode modes.members.normal} = { };
    };
    ${keys.bind [ closePane ]} = {
      ${keys.closeFocus} = { };
      ${keys.switchToMode modes.members.normal} = { };
    };
    ${keys.bind [ toggleFrames ]} = {
      ${keys.togglePaneFrames} = { };
      ${keys.switchToMode modes.members.normal} = { };
    };
  };
  ${keys.search} = with kms.modal.search.etries; {
    ${keys.bind [ halfPageScrollDown ]} = {
      ${keys.halfPageScrollDown} = { };
    };
    ${keys.bind [ searchDown ]} = {
      ${keys.searchDown} = { };
    };
    ${keys.bind [ searchUp ]} = {
      ${keys.searchUp} = { };
    };
    ${keys.bind [ toggleCaseSensitivity ]} = {
      ${keys.searchToggleOption searchOptions.members.caseSensitivity} = { };
    };
    ${keys.bind [ halfPageScrollUp ]} = {
      ${keys.halfPageScrollUp} = { };
    };
  };
  ${keys.modal.tab} =
    with kms.tab.entries;
    {
      ${keys.bind [ toggleTab ]} = {
        ${keys.toggleTab} = { };
      };
      ${keys.bind [ breakPaneIntoNewTab ]} = {
        ${keys.breakPane} = { };
        ${keys.switchToMode modes.members.normal} = { };
      };
      ${keys.bind [ newTab ]} = {
        ${keys.newTab} = { };
        ${keys.switchToMode modes.members.normal} = { };
      };
      ${keys.bind [ closeTab ]} = {
        ${keys.closeTab} = { };
        ${keys.switchToMode modes.members.normal} = { };
      };
    }
    // foldIntegersBetween1And9IntoAttrs (idx: {
      ${
        keys.bind [
          (chadLib.core.getAttr "goToTab${(toString idx)}" kms.modal.tab)
        ]
      } =
        {
          ${keys.goToTab idx} = { };
          ${keys.switchToMode modes.members.normal} = { };
        };
    });
  ${keys.scroll} = with kms.modal.scroll; {
    ${keys.bind [ halfPageScrollDown ]} = {
      ${keys.halfPageScrollDown} = { };
    };
    ${keys.bind [ singleLineScrollDown ]} = {
      ${keys.scrollDown} = { };
    };
    ${keys.bind [ singleLineScrollUp ]} = {
      ${keys.scrollUp} = { };
    };
    ${keys.bind [ switchToEnterSearchMode ]} = {
      ${keys.switchToMode modes.members.enterSearch} = { };
      # FIXME: this does not work with the default KDL renderer
      # as NIX does not preserve attrset entries order. Instead,
      # it orders them alphabetically.
      # ${keys.searchInput 0} = { };
    };
    ${keys.bind [ halfPageScrollUp ]} = {
      ${keys.halfPageScrollUp} = { };
    };
  };
  ${keys.sharedExcept (with modes.members; [ locked ])} = {
    ${keys.bind [ kms.common.moveFocusLeft ]} = {
      ${keys.moveFocus directions.members.left} = { };
    };
    ${keys.bind [ kms.common.moveFocusDown ]} = {
      ${keys.moveFocus directions.members.down} = { };
    };
    ${keys.bind [ kms.common.moveFocusUp ]} = {
      ${keys.moveFocus directions.members.up} = { };
    };
    ${keys.bind [ kms.common.moveFocusRight ]} = {
      ${keys.moveFocus directions.members.right} = { };
    };
    ${keys.bind [ kms.common.toggleFrames ]} = {
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
}
