#include "\life_server\script_macros.hpp"
/*
    File: fn_druglabInit.sqf
    Author: damian...

*/

private _pos = DRUGLAB_SETTINGS(getArray, "building_position");
private _druglab = nearestObject[_pos, "Land_Ryb_domek"];
_druglab setVariable ["rl_dl_building",true,true];
_druglab setVariable ["bis_disabled_Door_1",1,true]; //lock door
_druglab setVariable ["locked",true,true]; //lock Trunk
_druglab allowDamage false;

private _pos = DRUGLAB_SETTINGS(getArray,"powerbox_position"); //set powerbox position
[_pos, "Land_TransferSwitch_01_F",1,[0,0,0],272,{0},false] call BIS_fnc_spawnObjects; //spawn powerbox
private _powerbox = nearestObject[_pos,"Land_TransferSwitch_01_F"];
_powerbox setVariable ["rl_dl_powerbox",true,true];

[] call TON_fnc_druglabFill;