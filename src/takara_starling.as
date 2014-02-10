package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(frameRate="60", backgroundColor="#008080"]
	public class takara_starling extends Sprite
	{
		private var star:Starling;
		
		public function takara_starling()
		{
			var viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, Root.STAGE_WIDTH, Root.STAGE_HEIGHT),
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
				ScaleMode.SHOW_ALL
			);
			
			star = new Starling(Root, stage, viewPort);
			star.stage.stageWidth = Root.STAGE_WIDTH;
			star.stage.stageHeight = Root.STAGE_HEIGHT;
			star.start();
		}
	}
}
import starling.display.Quad;
import starling.display.Sprite;

class Root extends Sprite
{
	public static const STAGE_WIDTH:uint = 1080;
	public static const STAGE_HEIGHT:uint = 1440;
	
	public function Root()
	{
		var quad:Quad = new Quad(STAGE_WIDTH, STAGE_HEIGHT);
		quad.x = 0;
		quad.y = 0;
		
		var quad2:Quad = new Quad(STAGE_WIDTH-20, STAGE_HEIGHT-20, 0);
		quad2.x = 10;
		quad2.y = 10;
		
		addChild(quad);
		addChild(quad2);
	}
}