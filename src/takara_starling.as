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
import starling.events.TouchEvent;
import starling.events.TouchPhase;

class Root extends Sprite
{
	// 4:3
	public static const STAGE_WIDTH:uint = 1080;
	public static const STAGE_HEIGHT:uint = 1440;

	private var player:Player;
	
	public function Root()
	{
		addEventListener(Event.ADDED_TO_STAGE, onRootCreated);
	}
	
	private function onRootCreated(e:Event):void
	{
		removeEventListener(Event.ROOT_CREATED, onRootCreated);
		
		var bg:Image = SpriteSheet.getImage("OBJ_BACK");
		bg.scaleX = bg.scaleY = 4;
		addChild(bg);
		
		player = new Player();
		addChild(player);
		
		Input.registerListener(this);
		
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):void
	{
		player.main();
	}
}

class Input
{
	public static var touchX:Number = 0;
	public static var touchY:Number = 0;
	
	public static var down:Boolean = false;
	
	public static function registerListener(listener:Sprite):void
	{
		listener.addEventListener(TouchEvent.TOUCH, onTouch);
	}
	
	private static function onTouch(e:TouchEvent):void
	{
		switch(e.touches[0].phase)
		{
		case TouchPhase.BEGAN:
			touchX = e.touches[0].globalX;
			touchY = e.touches[0].globalY;
			down = true;
			break;
		case TouchPhase.MOVED:
			touchX = e.touches[0].globalX;
			touchY = e.touches[0].globalY;
			break;
		case TouchPhase.ENDED:
			down = false;
			break;
		}
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
		// TODO 内部で毎回Imageがnewされるため改善の余地あり
		image.texture = SpriteSheet.getImage(imageName, value).texture;
		_currentFrame = value;
	}
}

class Player extends GameObject
{
	private var count:int;
	private var destX:int;
	public function Player()
	{
		x = 540;
		y = 1200;
		
		destX = 540;
		
		setGraphic("OBJ_PLAYER");
	}
	
	override public function main():void
	{
		//移動
		if(Input.down == true)
		{
			var preX:Number = x;
			destX = Input.touchX;
		}
		
		x = (x * 4 + destX) / 5;
		
		//アニメーション
		if(x - preX < -12) {
			currentFrame = 7+count%3;
		}
		else if(x - preX > 12) {
			currentFrame = 10+count%3;
		}
		else if(x - preX < -4) {
			currentFrame = 1+count%3;
		}
		else if(x - preX > 4) {
			currentFrame = 4+count%3;
		}
		else {
			currentFrame = 0;
		}
		
		count++;
	}
}
