/*
 * Author: BaerMitUmlaut
 * Calculates the current metabolic costs for a unit.
 * Calculation is done according to the Pandolf/Wojtowicz formulas.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Metabolic cost <NUMBER>
 *
 * Example:
 * [_player, true] call ace_fatigue_fnc_getMetabolicCosts
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_unit", "_v"];
private ["_currentPos", "_m", "_l", "_t", "_g", "_postureWeight", "_duty"];

_m = 70;                                                                        //unit weight
_l = loadAbs _unit * 0.1 * 1/2.2046;                                            //gear weight
_t = 1;                                                                         //terrain factor - not implemented, could cause problems with addon maps - TODO!
_g = (1 - ([0,0,1] vectorDotProduct (surfaceNormal position player))) * 8 + 1;  //terrain gradient
_duty = GVAR(animDuty);                                                         //animation duty (kneeling vs. standing)

if (underwater _unit) then {
    _g = 1;
    _duty = 4;
};

if (_v > 2) then {
    2.10*_m + 4*(_m+_l)*((_l/_m)^2) + _t*(_m+_l)*(0.90*(_v^2)+0.66*_v*_g) * 0.23 * _duty
} else {
    1.05*_m + 2*(_m+_l)*((_l/_m)^2) + _t*(_m+_l)*(1.15*(_v^2)+0.66*_v*_g) * 0.23 * _duty
};
