#include "\life_server\script_macros.hpp"
/*
    File: fn_rsCleanup.sqf
    Author: damian
    Description: waits for the given Time and then resets the restartspawn condition
*/

private _maxRespawnTime = LIFE_SETTINGS(getNumber,"max_time_restartspawn");

waitUntil {serverTime > _maxRespawnTime};

_query = format ["SELECT id FROM vehicles WHERE active='2'"];
_queryResult = [_query,2,true] call DB_fnc_asyncCall;

{

_query = format ["UPDATE vehicles SET active='0', inventory='""[[],0]""', gear='""[]""' WHERE id='%1' ",_x#0];
[_query,1] call DB_fnc_asyncCall;

} forEach _queryResult;
