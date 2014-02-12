package game.core
{
	import game.object.BackGround;
	import game.object.GameObjectLayer;
	import game.object.Player;
	import game.object.Takara;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Root extends Sprite
	{
		// 4:3
		public static const STAGE_WIDTH:uint = 1080;
		public static const STAGE_HEIGHT:uint = 1440;
		
		private var bgLayer:GameObjectLayer;
		private var takaraLayer:GameObjectLayer;
		private var playerLayer:GameObjectLayer;
		
		public function Root()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ROOT_CREATED, onAddedToStage);
			
			bgLayer = new GameObjectLayer();
			takaraLayer = new GameObjectLayer();
			playerLayer = new GameObjectLayer();
			
			// 表示順序
			addChild(bgLayer);
			addChild(playerLayer);
			addChild(takaraLayer);
			
			bgLayer.addObject(new BackGround());
			playerLayer.addObject(new Player());
			
			for (var i:int = 0; i < 10; i++) 
			{
				var takara:Takara = new Takara();
				takara.x = Math.random() * STAGE_WIDTH;
				takara.y = Math.random() * 500;
				playerLayer.addObject(takara);
			}
			
			Input.registerListener(this);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			// 処理順序
			bgLayer.execute();
			takaraLayer.execute();
			playerLayer.execute();
		}
	}
}
