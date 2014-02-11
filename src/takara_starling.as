package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(frameRate="60", backgroundColor="#000000"]
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

import game.resources.SpriteSheet;

import starling.display.Image;
import starling.display.Sprite;

class Root extends Sprite
{
	public static const STAGE_WIDTH:uint = 1080;
	public static const STAGE_HEIGHT:uint = 1440;
	
	public function Root()
	{
		var bg:Image = SpriteSheet.getImage("OBJ_BACK");
		
		bg.scaleX = bg.scaleY = 4;
		addChild(bg);
		
		var player:Player = new Player();
		
		addChild(player);
	}
}

class Player extends Sprite
{
	public function Player()
	{
		var image:Image = SpriteSheet.getImage("OBJ_PLAYER");
		
		image.x = 540;
		image.y = 1200;
		
		addChild(image);
	}
}
