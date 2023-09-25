<pre>
 _____   __  ___                 __  ______                      __      
/__  /  /  |/  /___  _________  / /_/_  __/___ __________ ____  / /______
  / /  / /|_/ / __ \/ ___/ __ \/ __ \/ / / __ `/ ___/ __ `/ _ \/ __/ ___/
 / /__/ /  / / /_/ / /  / /_/ / / / / / / /_/ / /  / /_/ /  __/ /_(__  ) 
/____/_/  /_/\____/_/  / .___/_/ /_/_/  \__,_/_/   \__, /\___/\__/____/  
                      /_/                         /____/                 
</pre>

## Installation

Put BlendTargets.js in your UDB scripts folder.

## Usage

Move sectors to desired positions. Select the `Blend Targets` script, specify a target index and then run the script.

## BlendFloor

This function blends the floors of sectors with a specific tag to a target height.

### Parameters
* `tag` [int]: The tag specifying which sectors to blend.
* `key` [int]: The key used to identify the specific floor height state.
* `speed` [int, optional, default: 16]: The speed at which the floors will blend. If set to 0, a default speed of 8 is used.

## BlendFloorSync

Blends the floors of sectors with a specific tag to a target height synchronously.

### Parameters
* `tag` [int]: The tag specifying which sectors to blend.
* `key` [int]: The key used to identify the specific floor height state.
* `speed` [int, optional, default: 16]: The speed at which the floors will blend. If set to 0, a default speed of 16 is used.


## BlendCeil

This function blends the Ceilings of sectors with a specific tag to a target height.

### Parameters
* `tag` [int]: The tag specifying which sectors to blend.
* `key` [int]: The key used to identify the specific Ceiling height state.
* `speed` [int, optional, default: 16]: The speed at which the Ceilings will blend. If set to 0, a default speed of 8 is used.

## BlendCeilSync

Blends the Ceilings of sectors with a specific tag to a target height synchronously.

### Parameters
* `tag` [int]: The tag specifying which sectors to blend.
* `key` [int]: The key used to identify the specific Ceiling height state.
* `speed` [int, optional, default: 16]: The speed at which the Ceilings will blend. If set to 0, a default speed of 16 is used.
