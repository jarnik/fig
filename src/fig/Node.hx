package fig;

import fig.Component;

class Node
{
    
    public var name : String;
    
    private var _children : Array<Node>;
    private var _components : Array<Component>;
    private var _active : Bool = true;
    
    private var _transform : Transform;
    
    public function new(_name:String = "")
    {
        this._children = [];
        this._components = [];
        this.name = _name;
        this._transform = this.addComponent(Transform);
    }
    
    public function addChild(child:Node):Node
    {
        this._children.push(child);
        return child;
    }
    
    public function removeChild(child:Node):Void
    {
        this._children.remove(child);
    }
    
    public var children(get,null):Array<Node>;
    public function get_children():Array<Node>
    {
        return this._children;
    }
    
    public var active(get,set):Bool;
    public function get_active():Bool
    {
        return this._active;
    }
    public function set_active(_value:Bool):Bool
    {
        this._active = _value;
        return this._active;
    }
    
    public function addComponent<T:Component>(t:Class<Component>, args:Array<Dynamic> = null) : Null<T>
    {
        if (args == null)
        {
            args = [];
        }
        var c:Component = Type.createInstance(t, args);
        addExistingComponent(c);
        return cast c;
    }
    
    public function addExistingComponent(c:Component) : Void
    {
        this._components.push(c);
        c.node = this;
        c.awake();
    }
    
    public function removeComponent(component:Component):Void
    {
        this._components.remove(component);
        component.node = null;
    }
    
    public var transform(get,null):Transform;
    public function get_transform():Transform
    {
        return this._transform;
    }
    
    public function update() : Void
    {
        for (c in this.components)
        {
            c.update();
        }
        for (c in this.children)
        {
            c.update();
        }            
    }
    
    public function getComponent<T:Component>(t:Class<Component>) : Null<T>
    {
        for (c in this.components)        
        {
            if ( Type.getClass(c) == t )
            {
                return cast c;
            }
        }
        return null;
    }
    
    public var components(get,null):Array<Component>;
    public function get_components():Array<Component>
    {
        return _components;
    }
    
}