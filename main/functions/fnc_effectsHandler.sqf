/*
 * Author: BaerMitUmlaut
 * Handles any audible, visual or physical effects of fatigue.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Fatigue <NUMBER>
 * 2: Overexhausted <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_player, true] call ace_fatigue_fnc_effectsHandler
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_unit", "_fatigue", ["_overexhausted", false]];

//Audible effects
GVAR(lastBreath) = GVAR(lastBreath) + 1;
if (_fatigue > 0.4 && {GVAR(lastBreath) > (_fatigue * -10 + 9)}) then {
    switch (true) do {
        case (_fatigue < 0.6): {
            playSound (QGVAR(breathLow) + str(floor random 6));
        };
        case (_fatigue < 0.85): {
            playSound (QGVAR(breathMid) + str(floor random 6));
        };
        default {
            playSound (QGVAR(breathMax) + str(floor random 6));
        };
    };
    GVAR(lastBreath) = 0;
};

//Visual effects
GVAR(ppeBlackoutLast) = GVAR(ppeBlackoutLast) + 1;
if (GVAR(ppeBlackoutLast) == 1) then {
    GVAR(ppeBlackout) ppEffectAdjust [1,1,0,[0,0,0,1],[0,0,0,0],[1,1,1,1],[10,10,0,0,0,0.1,0.5]];
    GVAR(ppeBlackout) ppEffectCommit 1;
} else {
    if (_fatigue > 0.90) then {
        if (GVAR(ppeBlackoutLast) > (100 - _fatigue * 100) / 3) then {
            GVAR(ppeBlackout) ppEffectAdjust [1,1,0,[0,0,0,1],[0,0,0,0],[1,1,1,1],[2,2,0,0,0,0.1,0.5]];
            GVAR(ppeBlackout) ppEffectCommit 1;
            GVAR(ppeBlackoutLast) = 0;
        };
    };
};

//Physical effects
if (_overexhausted) then {
    _unit forceWalk true;
    _unit setAnimSpeedCoef 0.8;
    [_unit, objNull, ace_hitreactions_minDamageToTrigger + 0.1] call ace_hitreactions_fnc_fallDown;
} else {
    if (isForcedWalk _unit && {_fatigue < 0.7}) then {
        _unit forceWalk false;
        _unit setAnimSpeedCoef 1;
    } else {
        if ((isSprintAllowed _unit) && {_fatigue > 0.7}) then {
            _unit allowSprint false;
        } else {
            if ((!isSprintAllowed _unit) && {_fatigue < 0.6}) then {
                _unit allowSprint true;
            };
        };
    };
};
switch (stance _unit) do {
    case ("STAND"): {
        _unit setCustomAimCoef (1.5 + _fatigue * _fatigue * 5);
    };
    case ("CROUCH"): {
        _unit setCustomAimCoef (1.2 + _fatigue * _fatigue * 5);
    };
    case ("CROUCH"): {
        _unit setCustomAimCoef (1 + _fatigue * _fatigue * 4);
    };
    default {
        _unit setCustomAimCoef (1.5 + _fatigue * _fatigue * 5);
    };
};
