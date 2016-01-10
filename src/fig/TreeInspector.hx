package fig;

import fig.Node;
import sys.net.Socket;

class TreeInspector
{
    
    private var root : Node;
    private var socket: Socket;
    
    public function new(_root:Node)
    {
        this.root = _root;
        
        this.socket = new sys.net.Socket();
        socket.bind(new sys.net.Host("localhost"),5000);
        socket.listen(1);
        // trace("Starting server...");
        
        neko.vm.Thread.create(this.startServer);
    }
    
    private function startServer() : Void
    {
        while( true )
        {
            var c : sys.net.Socket = this.socket.accept();
            trace("Client connected...");
            var xml:String = '<?xml version="1.0" encoding="UTF-8" ?>'+getNodeXML(this.root).toString();
            c.write(xml);
            c.close();
        }
    }
    
    private function getNodeXML( node:Node ) : Xml
    {
        var xml:Xml = Xml.createElement("node");
        xml.set("name", node.name);
        xml.set("active", Std.string(node.active));
        
        var components:Xml = Xml.createElement("components");
        for (c in node.components)
        {
            components.addChild( getComponentXML(c) );
        }
        xml.addChild(components);
        
        var children:Xml = Xml.createElement("children");
        for (c in node.children)
        {
            children.addChild( getNodeXML(c) );
        }
        xml.addChild(children);
        
        return xml;
    }
    
    private function getComponentXML( c:Component ) : Xml
    {
        var xml:Xml = Xml.createElement(Type.getClassName(Type.getClass(c)));
        var propClassName:String;
        for (propName in Type.getInstanceFields(Type.getClass(c)))
        {
            //propClass = Type.getClass(Reflect.field(c,propName));
            propClassName = Type.getClassName(Type.getClass(Reflect.field(c,propName)));
            // trace("prop "+propName+" "+propClassName);
            if (
                propClassName == "Int" ||
                propClassName == "String" ||
                propClassName == "Float" ||
                propClassName == "Bool"
                //Std.is(Reflect.field(c,propName), Float)
                //(Type.getClass(Reflect.field(c,propName)))
                //Reflect.isFunction(Reflect.field(c,propName))
            )
            {
                xml.set(  
                    propName, 
                    Std.string(Reflect.field(c,propName))
                );
            }
            
        }
        
        return xml;
    }
    
    
}