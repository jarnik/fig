package fig;

class Image extends Component
{
    
    public var url : String = null;
    
    public function new(_url:String)
    {
        super();
        this.url = _url;
    }
    
    public function getContentWidth() : Float
    {
#if openfl
        return openfl.Assets.getBitmapData(this.url).width;
#end        
        return 0;
    }
    
    public function getContentHeight() : Float
    {
#if openfl
        return openfl.Assets.getBitmapData(this.url).height;
#end        
        return 0;
    }
    
    
}