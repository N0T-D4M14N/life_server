#include "\life_server\script_macros.hpp"
/*
    File: fn_handleShots.sqf
    Author: damian.

*/

_this#0 params ["_playerID", "_playerName", "_playerSide", "_date", "_weapon", "_shotCount"];

private _query = format ["INSERT INTO logsfired (steamid, playername, playerside, date_first_shot, weapon, shots) VALUES('%1', '%2', '%3', '%4', '%5', '%6')",_playerID, _playerName, _playerSide, _date, _weapon, _shotCount];
[_query,1] call DB_fnc_asyncCall;
