package fig;

class Component
{
    
    public var node : Node;
    private var _enabled : Bool = true;
    
    public function new()
    {
    }
    
    public function awake() {}
    
    public var enabled(get,set):Bool;
    public function get_enabled():Bool
    {
        return this._enabled;
    }
    public function set_enabled(_value:Bool):Bool
    {
        this._enabled = _value;
        return this._enabled;
    }    
    
    public function update() : Void
    {
    }
    
}