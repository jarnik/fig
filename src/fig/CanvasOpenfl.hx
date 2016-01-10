package fig;

import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.display.Bitmap;
import openfl.Assets;

class CanvasOpenfl extends Component
{
    
    private var canvas: Sprite;
    
    public function new() : Void
    {
        super();
        this.canvas = new Sprite();
    }
    
    public function getCanvas() : Sprite
    {
        return this.canvas;
    }
    
    override public function update() : Void
    {
        super.update();
        
        renderNode(this.node, this.canvas);
    }
    
    private function renderNode(n:Node,s:Sprite) : Void
    {
        // trace("RENDER NODE");
        s.x = n.transform.x;
        s.y = n.transform.y;
        s.rotation = n.transform.angle;
        s.scaleX = n.transform.scaleX;
        s.scaleY = n.transform.scaleY;
        
        var image:Image = n.getComponent(Image);
        var spriteIndex:Int = 0;
        if (image != null)
        {
            renderImage(s,image);
            spriteIndex++;
        }
        
        var childSprite:Sprite = null;
        // trace(" > NODE children "+n.children.length);
        for (i in 0...n.children.length)
        {
            if (s.numChildren == 0 || s.numChildren <= spriteIndex)
            {
                childSprite = new Sprite();
                s.addChild(childSprite);
            } else 
            {            
                // TODO it might be prevalent non-Sprite, check here
                childSprite = cast(s.getChildAt(spriteIndex), Sprite);
            }
            spriteIndex++;
            renderNode(n.children[i], childSprite);
        }
        
        // remove legacy children
        while (spriteIndex < s.numChildren)
        {
            s.removeChildAt(spriteIndex);
        }
    }
    
    private function renderImage(s:Sprite,i:Image) : Void
    {            
        var bitmap:Bitmap = null;
        if (s.numChildren == 0 || !Std.is(s.getChildAt(0), Bitmap))
        {
            // bitmap not found, create new
            bitmap = new Bitmap();
            s.addChildAt(bitmap,0);
            bitmap.bitmapData = Assets.getBitmapData(i.url);
            // trace(" >  bitmap w "+bitmap.bitmapData.width);
        }
        // bitmap = cast(s.getChildAt(0), Bitmap);
        // TODO update image
    }
    
    
}