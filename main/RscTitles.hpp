class RscProgress;

class RscTitles {
    class RscAnaerobicReserveBar {
        idd = -1;
        movingEnable = 0;
        enableSimulation = 1;
        fadein = 0;
		fadeout = 0;
		duration = 10e10;

        onLoad = QUOTE(GVAR(fatigueBarShown) = true; uiNamespace setVariable [ARR_2(QUOTE(QGVAR(fatigueBar)),(_this select 0) displayCtrl 3)]);

        controlsBackground[] = {CtrlBar};
        controls[] = {};

        class CtrlBar: RscProgress {
            idc = 3;
            x = "(profilenamespace getvariable [""IGUI_GRID_STAMINA_X"", ((safezoneX + safezoneW) -	(10 * (((safezoneW / safezoneH) min 1.2) / 40)) - 4.3 * (((safezoneW / safezoneH) min 1.2) / 40))])";
			y = "(profilenamespace getvariable [""IGUI_GRID_STAMINA_Y"", (safezoneY + 4.05 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])";
			w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorFrame[] = {0,0,0,0};
            colorBar[] = {1,1,1,0.2};
            texture = "#(argb,8,8,3)color(1,1,1,0.2)";
            shadow = 0;
        };
    };
};
