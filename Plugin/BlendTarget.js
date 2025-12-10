/*jshint esversion: 9*/
/// <reference path="./../../../udbscript.d.ts" />
`#version 4`;

`#name Blend Targets`;

`#description Set blend targets`;

// --------------------------------------------------------------
// Script Options
// These options appear in UDB’s UI when the script is run.
// --------------------------------------------------------------
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
// Retrieve all currently selected sectors in the map editor
let sectors = UDB.Map.getSelectedSectors();

// The user chooses which blend target slot this script should modify.
// Example results: user_floorblend_0, user_floorblend_1, etc.
const targetindex = UDB.ScriptOptions.targetindex;
const floorfield = `user_floorblend_${targetindex}`;
const ceilfield = `user_ceilingblend_${targetindex}`;
var fields = [];

const mode = UDB.ScriptOptions.operation;

// Stores the sector's current floor and ceiling heights into
// custom user fields. These values act like morph target anchors.
function setBlendTarget(sector)
{
    // Initialize fields so they exist before assignment
    sector.fields[ceilfield] = 1.0;
    sector.fields[floorfield] = 1.0;
    
    // Read numeric heights; fallback to 0 if null or invalid
    var ceil = Number(sector.ceilingHeight);
    var flr = Number(sector.floorHeight);

    if (!ceil) ceil = 0n;
    if (!flr) flr = 0n;

    // Store the heights in the custom blend fields
    sector.fields[ceilfield] = ceil;
    sector.fields[floorfield] = flr;

    //UDB.log(`${floorfield} : ${sector.floorHeight}`);
    //UDB.log(`${ceilfield} : ${sector.ceilingHeight}`);
}

// Removes the custom user fields so the blend target is cleared.
function clearBlendTarget(sector)
{
    sector.fields[ceilfield] = null;
    sector.fields[floorfield] = null;
}

// Copies the stored height values back into the sector's actual
// floor and ceiling heights, allowing an in-editor preview.
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


// Execute the selected action on all selected sectors.
sectors.forEach(sector=>{

    switch (mode) 
    {
        case 0: setBlendTarget(sector); break;
        case 1: clearBlendTarget(sector); break;
        case 2: previewTarget(sector); break;
    }
})

