package fig;

class Time
{
    
    public static var deltaTime:Float;
    
    public static var current:Float;
    public static function get_current():Float
    {
        return openfl.Lib.getTimer() / 1000;
    }
    
}