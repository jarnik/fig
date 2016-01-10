package fig;

class Timer
{
    
    public var startTime:Float = -1;
    public var duration:Float;
    
    public function new() : Void
    {        
    }
    
    public function start(_duration:Float) : Void
    {
        this.duration = _duration;
        this.startTime = Time.current;
    }
    
    public function reset() : Void
    {
        
    }
    
    
    public function isActive() : Bool
    {
        if (isStarted() && Time.current < (this.startTime + this.duration))
        {
            return true;
        }
        return false;
    }
    
    public function isStarted() : Bool
    {
        return (startTime >= 0);
    }
    
    
    
}