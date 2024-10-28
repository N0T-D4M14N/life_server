#include "\life_server\script_macros.hpp"
/*
    File: fn_afterRestartSpawn.sqf
    Author: damian.
    Description: checks for player and spawns vehicle
*/
_this#0 params ["_unit"];

private _pID = getPlayerUID _unit;

_query = format ["SELECT id,pid,position,rotation FROM vehicles WHERE active='2' AND pid='%1'",_pID];
_queryResult = [_query,2,true] call DB_fnc_asyncCall;

if (_queryResult isEqualTo []) exitWith {diag_log "[INFO] Es wurde kein Fahrzeug gespeichert vor dem Restart."};

private _countVehicles = 0;
private _maxCountVehicles = LIFE_SETTINGS(getNumber,"max_saved_vehicles");

{
private _price = 0; //test for available numbers
private _position = _x#2;
_position = parseSimpleArray _position;//cleaneren Weg finden

if (serverTime > 900) then {
    private _vehicle = [_x#2, 0, "[[],0]", "[]", _x#3, 0, 0, _x#3, 1];
    [_vehicle] remoteExecCall ["TON_fnc_updateVehicle",2];
} else {
    [_x#0,_x#1,_position,_unit,_price,_x#3,"Dein Fahrzeug steht jetzt wieder bereit!"] remoteExec ["TON_fnc_spawnVehicle",2];
};

_countVehicles = _countVehicles +1;

if (_countVehicles isEqualTo _maxCountVehicles) exitWith {diag_log "Spawned Vehicles"};

} forEach _queryResult;
