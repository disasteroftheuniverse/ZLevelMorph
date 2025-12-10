class MorphTarget play
{
    const CEILING_KEY = "user_ceilingblend";
    const FLOOR_KEY = "user_floorblend";

	/// <summary>
    /// Moves the floor of all sectors with the given tag to the stored blend target height.
    /// </summary>
    /// <param name="tag">Sector tag to operate on. If zero, nothing happens.</param>
    /// <param name="key">Blend target index, appended to 'user_floorblend_'</param>
    /// <param name="speed">
    /// Speed of movement
    /// Defaults to 16 if omitted.
    /// </param>
    static void BlendFloor (int tag, int key, int speed = 16)
    {
        if (!tag)return;
        if (!speed) speed = 8;
        int index;
        string blendkey = string.format("%s_%i", FLOOR_KEY, key); 

        SectorTagIterator it = Level.CreateSectorTagIterator(tag);
        while (  true )
        {
			index = it.next();
			console.printf("Tag: %i;", index);
            if (index < 0) break;
            sector sec = Level.Sectors[index];
            if (!sec) continue;

            double targetheight = double(sec.GetUDMFFloat(blendkey));
            Level.CreateFloor(sec, Floor.floorMoveToValue, null, double(speed)/8., targetheight);
        } 
    }

    /// <summary>
    /// Moves floors of tagged sectors toward their blend target height,
    /// with movement duration scaled to the actual distance.
    /// </summary>
    /// <param name="tag">Sector tag to operate on.</param>
    /// <param name="key">Blend target index.</param>
    /// <param name="speed">
    /// Speed of movement
    /// Larger values = slower, smoother motion.
    /// </param>
    static void BlendFloorSync (int tag, int key, int speed = 16)
    {
        if (!tag)return;
        if (!speed) speed = 16;
        SectorTagIterator it = Level.CreateSectorTagIterator(tag);
        int index;
        string blendkey = string.format("%s_%i", FLOOR_KEY, key); 

        while (  true )
        {
			index = it.next();
			console.printf("Tag: %i;", index);
            if (index < 0) break;
            sector sec = Level.Sectors[index];
            if (!sec) continue;

            double height = -sec.floorplane.D;
            double targetheight = double(sec.GetUDMFFloat(blendkey));
            double delta = max(targetheight, height) - min (targetheight, height);

            if (delta)
            {
                Level.CreateFloor(sec, Floor.floorMoveToValue, null, (delta / double(speed)), targetheight);
            }
            
        } 

    }

    /// <summary>
    /// Moves ceiling of tagged sectors to the stored blend target height.
    /// </summary>
    /// <param name="tag">Sector tag to operate on.</param>
    /// <param name="key">Blend target index.</param>
    /// <param name="speed">Movement speed. Defaults to 16.</param>
    static void BlendCeil (int tag, int key, int speed = 16)
    {
        if (!tag)return;
        if (!speed) speed = 8;

        int index;
        string blendkey = string.format("%s_%i", CEILING_KEY, key); 
        SectorTagIterator it = Level.CreateSectorTagIterator(tag);

        while (  true )
        {
			index = it.next();
			console.printf("Tag: %i;", index);
            if (index < 0) break;
            sector sec = Level.Sectors[index];
            if (!sec) continue;
            double targetheight = double(sec.GetUDMFFloat(blendkey));
            Level.CreateCeiling(sec, Ceiling.ceilMoveToValue, null, double(speed)/8., double(speed)/8., targetheight);
        } 
    }

    /// <summary>
    /// Moves ceilings of tagged sectors toward blend target height,
    /// synchronizing the movement time to the height difference.
    /// </summary>
    /// <param name="tag">Sector tag.</param>
    /// <param name="key">Blend target index.</param>
    /// <param name="speed">Speed divisor determining duration.</param>
    static void BlendCeilSync (int tag, int key, int speed = 16)
    {
        if (!tag)return;
        if (!speed) speed = 8;

        int index;
        string blendkey = string.format("%s_%i", CEILING_KEY, key); 
        SectorTagIterator it = Level.CreateSectorTagIterator(tag);

        while (  true )
        {
			index = it.next();
			console.printf("Tag: %i;", index);
            if (index < 0) break;
            sector sec = Level.Sectors[index];
            if (!sec) continue;
            double height = sec.ceilingplane.D;
            double targetheight = double(sec.GetUDMFFloat(blendkey));
            double delta = max(targetheight, height) - min (targetheight, height);
            if (delta)
            {
                Level.CreateCeiling(sec, Ceiling.ceilMoveToValue, null, (delta / double(speed)), (delta / double(speed)), targetheight);
            }
        } 
    }

    /// <summary>
    /// Blends both floor and ceiling of tagged sectors using fixed-speed mode.
    /// </summary>
    /// <param name="tag">Sector tag.</param>
    /// <param name="key">Blend target index.</param>
    /// <param name="speed">Speed divisor.</param>
    static void BlendSec (int tag, int key, int speed = 16)
    {
        MorphTarget.BlendFloor(tag,key,speed);
        MorphTarget.BlendCeil(tag,key,speed);
    }

    /// <summary>
    /// Blends both floor and ceiling of tagged sectors using
    /// synchronized speed based on movement distance.
    /// </summary>
    /// <param name="tag">Sector tag.</param>
    /// <param name="key">Blend target index.</param>
    /// <param name="speed">Speed divisor.</param>
    static void BlendSecSync (int tag, int key, int speed = 16)
    {
        MorphTarget.BlendFloorSync(tag,key,speed);
        MorphTarget.BlendCeilSync(tag,key,speed);
    }
}
