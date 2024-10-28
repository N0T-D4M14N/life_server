#include "\life_server\script_macros.hpp"
/*
    File: fn_druglabFill.sqf
    Author: damian

*/

private _lootTable = DRUGLAB_SETTINGS(getArray, "possible_loot");
private _lootAmountMax = DRUGLAB_SETTINGS(getNumber, "loot_amount_max");

private _trunk = [[],0];

{
    private _lootAmount = round (random _lootAmountMax);
    _x params ["_cItemName","_cItemAmount"];
    
    _lootAmount = _lootAmount * _cItemAmount;

    private _cItemWeight = ITEM_WEIGHT(_cItemName);
    private _weight = _cItemWeight * _lootAmount;
    private _trunkWeight = _trunk#1 + _weight;

    private _data = _trunk#0;
    private _index = _data findIf {_x#0 == _cItemName};

    if (_index == -1) then {
        _data pushBack [_cItemName,_lootAmount];
    } else {
        _data set [_index,[_cItemName, (_data#_index#1) + _lootAmount]];
    };

    _trunk = [_data,_trunkWeight];

} forEach _lootTable;

rl_dl_vault setVariable ["Trunk",_trunk,true];