package game.core
{
	import game.object.Player;
	import game.object.Takara;
	import game.resources.SpriteSheet;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Root extends Sprite
	{
		// 4:3
		public static const STAGE_WIDTH:uint = 1080;
		public static const STAGE_HEIGHT:uint = 1440;
		
		private var player:Player;
		private var takara:Takara;
		
		public function Root()
		{
			addEventListener(Event.ADDED_TO_STAGE, onRootCreated);
		}
		
		private function onRootCreated(e:Event):void
		{
			removeEventListener(Event.ROOT_CREATED, onRootCreated);
			
			var bg:Image = SpriteSheet.getImage("OBJ_BACK");
			bg.scaleX = bg.scaleY = 4;		// 背景画像は低解像度で格納しているため拡大する
			addChild(bg);
			
			player = new Player();
			addChild(player);
			
			takara = new Takara();
			addChild(takara);
			
			Input.registerListener(this);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			player.main();
			takara.main();
		}
	}
}