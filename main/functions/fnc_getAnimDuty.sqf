/*
 * Author: BaerMitUmlaut
 * Calculates the duty of the current animation.
 *
 * Arguments:
 * 0: Animation name <STRING>
 *
 * Return Value:
 * Duty <NUMBER>
 *
 * Example:
 * ["AidlPercMstpSlowWrflDnon_G05"] call ace_fatigue_fnc_getAnimDuty
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_animName"];
private ["_animPrefix", "_unitPos", "_duty"];

_duty = 1;

_animPrefix = _animName select [0, 4];
if ((_animPrefix == "Aidl") || {_animPrefix == "Amov"}) then {
    _unitPos = _animName select [5, 3];
    switch (_unitPos) do {
        case ("erc"): {
            _duty = 1;
        };
        case ("knl"): {
            _duty = 1.5;
        };
        case ("pne"): {
            _duty = 20; //due to the slow speed, this needs an extremly high duty
        };
    };

    if ((_animName select [9, 3]) == "tac") then {
        _duty = _duty * 1.5;
    };
    if ((_animName select [13, 3]) == "ras") then {
        _duty = _duty * 1.2;
    };
};

if (_unit getVariable ["ace_dragging_isCarrying", false]) then {
    _duty = _duty * 3;
};

_duty
