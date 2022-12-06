weedfield <- [];

/* Weed status 
1 - growing
2 - flowering
3 - ready to harvest
*/

function AddWeedPlant( pos )
{
    local getpos = Vector( pos.x, pos.y, ( pos.z - 2.9 ) );
    local obj = AddObject( 6000, 1, getpos, "weed" );
    weedfield.append( 
    {
        Pos = pos,
        Status = 1,
        Time = time(),
        Object = obj,
    });

   
}

function CheckWeedStatus()
{
    foreach( index, value in weedfield )
    {
        if( ( ( time() - value.Time ) > 1800 ) && value.Status == 1 )
        {
            value.Status = 2;
            value.Object.Pos.z += 1;
        } 

        if( ( ( time() - value.Time ) > 3600 ) && value.Status == 2 ) 
        {
            value.Status = 3;
            value.Object.Pos.z += 1;
        } 
    }
}

function GetNearestWeed( pos )
{
    foreach( index, value in weedfield )
    {
        if( value.Pos.Distance( pos ) <= 1 ) return index;
    }
}

function GetNearestWeed2( pos )
{
    foreach( index, value in weedfield )
    {
        if( value.Pos.Distance( pos ) <= 2 ) return index;
    }
}