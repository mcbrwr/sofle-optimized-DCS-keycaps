// Eigen keycap-profiel, gebaseerd op DCS.
// Gedeeld door key.scad (losse toets) en de layouts in layouts/.

include <./includes.scad>

// --- profiel per rij 0–4 (rij 4 = duimtoetsen) ---
heights   = [12,   8,    6,    6.5,  6];    // origineel DCS: 11.5, 8.5, 7.5, 6, 6
tilts     = [-14,  -10,  -3,   7,    -11];  // origineel DCS: -6, -1, 3, 7, 16
skews     = [1.75, 1.75, 1.75, 1.75, 0.8];  // origineel DCS: 1.75
fontSizes = [6,    6,    6,    6,    3];

// --- afgeschuinde bovenrand ---
top_bevel       = 1;  // breedte van de afschuining in mm (0 = scherpe rand)
top_bevel_steps = 1;  // 1 = rechte afschuining, 4+ = afgeronde rand

// --- homing bumps ---
home_keys  = ["F", "J"];
bump_depth = 0.5;    // hoogte van het randje
bump_edge  = 1.5;    // afstand vanaf de voorrand in mm

// --- print-instellingen ---
stem_slop = 0.45;

// tekst met meerdere tekens krimpt tot max. ±10 mm breed (±1,1 mm per teken per eenheid font size)
function legend_size(t, row) =
  len(t) <= 1 ? fontSizes[row] : min(fontSizes[row], 10 / (1.1 * len(t)));

function is_home(t) = len([for (h = home_keys) if (h == t) h]) > 0;

// t: legenda ("" = leeg kapje), row: profielrij 0–4
// length: lengte in units (verticaal), roll: kanteling opzij in graden
// bump: homing bump, standaard voor de toetsen in home_keys
module custom_key(t, row, length = 1, roll = 0, bump = undef) {
  let(
    // basismaten van DCS
    $bottom_key_width   = 18.16,
    $bottom_key_height  = 18.16,
    $width_difference   = 6,
    $height_difference  = 4,
    $dish_type          = "cylindrical",
    $dish_depth         = 0.5,
    $dish_skew_x        = 0,
    $dish_skew_y        = 0,

    $stem_slop          = stem_slop,
    $stem_support_type  = "disable",
    // bij kantelen opzij komt de lage kant omlaag; compenseer de hoogte
    $total_depth        = heights[row] + 6 * sin(abs(roll)),
    $top_tilt           = tilts[row],
    $top_skew           = skews[row],
    $key_height         = length,
    $double_sculpted    = roll != 0,
    $top_tilt_y         = roll,
    $key_bump           = is_undef(bump) ? is_home(t) : bump,
    $key_bump_depth     = bump_depth,
    $key_bump_edge      = bump_edge,
    $font_size          = legend_size(t, row),
    $inset_legend_depth = 0.6,
    $top_bevel          = top_bevel,
    $top_bevel_steps    = top_bevel_steps
  ) legend(t) key();
}
