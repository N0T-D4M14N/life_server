#include "\life_server\script_macros.hpp"
/*
    File: fn_updateVehicle.sqf
    Author: damian
    Description: updates vehicle data in db
*/
_this#0 params ["_pID","_plate","_vItems","_iItems","_position","_damage","_fuel","_rotation","_reason"];

switch (_reason) do {
    case 0: {
        private _query = format ["UPDATE vehicles SET active='2', inventory='%3', gear='%4', position='%5', damage='%6', fuel='%7', rotation='%8' WHERE pid='%1' AND plate='%2'",_pID,_plate,_vItems,_iItems,_position,_damage,_fuel,_rotation];
        [_query,1] call DB_fnc_asyncCall;
    };

    case 1: {
        private _query = format ["UPDATE vehicles SET active='0', inventory='%2', gear='%3' WHERE active='2' AND pid='%1'",_pID,_vItems,iItems];
        [_query,1] call DB_fnc_asyncCall;
    };

    case 2: {
        private _query = format ["UPDATE vehicles SET active='1' WHERE active='2' AND pid='%1' AND plate='%2'",_pID,_plate];
        [_query,1] call DB_fnc_asyncCall;
    };

    default {
        diag_log "[ERROR] Variable _reason wasnt either 0,1 or 2"
    };
};