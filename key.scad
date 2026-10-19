// Eén losse toets. Handig om profiel en instellingen te testen of een
// reservekapje te printen. Profiel en algemene instellingen: profile.scad

include <./profile.scad>

legend_text = "F";
row         = 2;    // [0:4]
length      = 1;    // lengte in units, bv. 1.5 voor de Sofle-duimtoets
roll        = 0;    // kanteling opzij in graden
bump        = "auto"; // ["auto", "on", "off"] auto = alleen voor home_keys

custom_key(legend_text, row, length, roll,
           bump == "auto" ? undef : bump == "on");
