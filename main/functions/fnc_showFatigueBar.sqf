/*
 * Author: BaerMitUmlaut
 * Shows a bar in the top right indicating the players current anaerobic fatigue.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_fatigue_fnc_showFatigueBar
 *
 * Public: No
 */

#include "script_component.hpp"

(QGVAR(layer) call BIS_fnc_rscLayer) cutRsc ["RscAnaerobicReserveBar", "PLAIN"];
