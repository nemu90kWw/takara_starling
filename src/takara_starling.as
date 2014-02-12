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
import starling.events.Event;

class Root extends Sprite
{
	// 4:3
	public static const STAGE_WIDTH:uint = 1080;
	public static const STAGE_HEIGHT:uint = 1440;

	private var player:Player;
	
	public function Root()
	{
		var bg:Image = SpriteSheet.getImage("OBJ_BACK");
		bg.scaleX = bg.scaleY = 4;
		addChild(bg);
		
		player = new Player();
		addChild(player);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame():void
	{
		player.main();
	}
}

class GameObject extends Sprite
{
	private var image:Image;
	private var imageName:String;
	
	private var _currentFrame:int;
	
	public function main():void
	{
		
	}
	
	// --------------------------------//
	// グラフィック処理
	// --------------------------------//
	public function setGraphic(name:String):void
	{
		imageName = name;
		
		image = SpriteSheet.getImage(name);
		addChild(image);
	}
	
	public function get currentFrame():int {return _currentFrame;}
	public function set currentFrame(value:int):void
	{
		image.texture = SpriteSheet.getImage(imageName, value).texture;
		_currentFrame = value;
	}
}

class Player extends GameObject
{
	public function Player()
	{
		x = 540;
		y = 1200;
		
		setGraphic("OBJ_PLAYER");
	}
	
	override public function main():void
	{
		currentFrame = (currentFrame + 1) % 13;
	}
}
