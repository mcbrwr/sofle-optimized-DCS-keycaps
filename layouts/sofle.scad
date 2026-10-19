// Volledige Sofle-keyset. Profiel en algemene instellingen: ../profile.scad

include <../profile.scad>

// --- losse duimtoetsen (BKS links, ENT rechts) ---
thumb_length = 1.5;  // lengte in units (verticaal)
thumb_roll   = 10;   // kanteling naar buiten in graden (0 = vlak)

// --- legenda's ("" = leeg kapje) ---
left = [
  ["ESC", "1!",  "2@",  "3#",  "4$",  "5%"],
  ["TAB", "Q",   "W",   "E",   "R",   "T"],
  ["CPS", "A",   "S",   "D",   "F",   "G"],
  ["SHT", "Z",   "X",   "C",   "V",   "B",   ""],
  ["CTL", "ALT", "GUI", "ESC", "BKS"]
];
right = [
  ["6^",  "7&",  "8*",  "9(",  "0)",  "BKS"],
  ["Y",   "U",   "I",   "O",   "P",   "-_"],
  ["H",   "J",   "K",   "L",   ";:",  "'\""],
  ["",    "N",   "M",   ",<",  ".>",  "/?",  "=+"],
  ["ENT", "SPC", "GUI", "ALT", "CTL"]
];

// "left", "right" of "both"
half = "both";

// offsets: verschuiving per rij in units (zodat de kolommen kloppen)
// big_col: kolom in de duimrij van de losse duimtoets
// roll: positief = linkerkant omlaag, negatief = rechterkant omlaag
module sofle_half(legends, x0, offsets, big_col, roll) {
  for (r = [0:4], c = [0:len(legends[r]) - 1]) {
    big = r == 4 && c == big_col;
    translate_u(x0 + c + offsets[r],
                -r - (big ? (thumb_length - 1) / 2 : 0))
      custom_key(legends[r][c], r, big ? thumb_length : 1, big ? roll : 0);
  }
}

// losse duimtoetsen kantelen naar de buitenkant van het toetsenbord
if (half != "right") sofle_half(left,  -2, [-1, -1, -1, -1,  1], 4,  thumb_roll);
if (half != "left")  sofle_half(right,  7, [-1, -1, -1, -2, -2], 0, -thumb_roll);
