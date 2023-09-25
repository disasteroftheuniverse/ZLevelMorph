/*jshint esversion: 9*/
/// <reference path="./../../../udbscript.d.ts" />
`#version 4`;

`#name Blend Targets`;

`#description Set blend targets`;

`#scriptoptions

operation
{
    description = "Action";
    default = 0; // North
    type = 11; // Enum
    enumvalues {
        0 = "Set Blend Target";
        1 = "Clear Blend Target";
        2 = "Preview";
    }
}

targetindex
{
    description = "Target Index";
    default = 0; // North
    type = 0; // Enum
}
`;

let sectors = UDB.Map.getSelectedSectors();
const targetindex = UDB.ScriptOptions.targetindex;
const floorfield = `user_floorblend_${targetindex}`;
const ceilfield = `user_ceilingblend_${targetindex}`;
var fields = [];

const mode = UDB.ScriptOptions.operation;

function setBlendTarget(sector)
{
    sector.fields[ceilfield] = 1.0;
    sector.fields[floorfield] = 1.0;

    var ceil = Number(sector.ceilingHeight);
    var flr = Number(sector.floorHeight);

    if (!ceil) ceil = 0n;
    if (!flr) flr = 0n;

    sector.fields[ceilfield] = ceil;
    sector.fields[floorfield] = flr;

    //UDB.log(`${floorfield} : ${sector.floorHeight}`);
    //UDB.log(`${ceilfield} : ${sector.ceilingHeight}`);
}

function clearBlendTarget(sector)
{
    sector.fields[ceilfield] = null;
    sector.fields[floorfield] = null;
}

function previewTarget(sector)
{
    if (sector.fields[floorfield]!=null && sector.fields[floorfield]!=undefined)
    {
        sector.floorHeight = sector.fields[floorfield];
    }

    if (sector.fields[ceilfield]!=null && sector.fields[ceilfield]!=undefined)
    {
        sector.ceilingHeight = sector.fields[ceilfield];
    }
}



sectors.forEach(sector=>{

    switch (mode) 
    {
        case 0: setBlendTarget(sector); break;
        case 1: clearBlendTarget(sector); break;
        case 2: previewTarget(sector); break;
    }
})

