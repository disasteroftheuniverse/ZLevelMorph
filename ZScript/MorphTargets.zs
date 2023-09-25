class MorphTarget
{
    const CEILING_KEY = "user_ceilingblend";
    const FLOOR_KEY = "user_floorblend";

    static void BlendFloor (int tag, int key, int speed = 16)
    {
        if (!tag)return;
        if (!speed) speed = 8;
        int index;
        string blendkey = string.format("%s_%i", FLOOR_KEY, key); 

        SectorTagIterator it = Level.CreateSectorTagIterator(tag);
        while ( index = it.next() )
        {
            if (index < 0) break;
            sector sec = Level.Sectors[index];
            if (!sec) continue;

            double targetheight = double(sec.GetUDMFFloat(blendkey));
            Level.CreateFloor(sec, Floor.floorMoveToValue, null, double(speed)/8., targetheight);
        } 
    }

    static void BlendFloorSync (int tag, int key, int speed = 16)
    {
        if (!tag)return;
        if (!speed) speed = 16;
        SectorTagIterator it = Level.CreateSectorTagIterator(tag);
        int index;
        string blendkey = string.format("%s_%i", FLOOR_KEY, key); 

        while ( index = it.next() )
        {
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

    static void BlendCeil (int tag, int key, int speed = 16)
    {
        if (!tag)return;
        if (!speed) speed = 8;

        int index;
        string blendkey = string.format("%s_%i", CEILING_KEY, key); 
        SectorTagIterator it = Level.CreateSectorTagIterator(tag);

        while ( index = it.next() )
        {
            if (index < 0) break;
            sector sec = Level.Sectors[index];
            if (!sec) continue;
            double targetheight = double(sec.GetUDMFFloat(blendkey));
            Level.CreateCeiling(sec, Ceiling.ceilMoveToValue, null, double(speed)/8., double(speed)/8., targetheight);
        } 
    }

    static void BlendCeilSync (int tag, int key, int speed = 16)
    {
        if (!tag)return;
        if (!speed) speed = 8;

        int index;
        string blendkey = string.format("%s_%i", CEILING_KEY, key); 
        SectorTagIterator it = Level.CreateSectorTagIterator(tag);

        while ( index = it.next() )
        {
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

    static void BlendSec (int tag, int key, int speed = 16)
    {
        SunsetLevelThinker.BlendFloor(tag,key,speed);
        SunsetLevelThinker.BlendCeil(tag,key,speed);
    }
    
    static void BlendSecSync (int tag, int key, int speed = 16)
    {
        MorphTarget.BlendFloorSync(tag,key,speed);
        MorphTarget.BlendCeilSync(tag,key,speed);
    }
}