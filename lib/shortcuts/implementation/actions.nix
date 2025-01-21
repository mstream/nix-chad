{ chadLib, ... }:
chadLib.enum.create {
  mappings = {
    id = {
      screenshot = 28;
      screenshotToClipboard = 29;
      screenshotRegion = 30;
      screenshotRegionToClipboard = 31;
    };
  };
  memberNames = [
    "screenshot"
    "screenshotToClipboard"
    "screenshotRegion"
    "screenshotRegionToClipboard"
  ];
  name = "actions";
}
