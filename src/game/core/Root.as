package game.core
{
	import game.object.BackGround;
	import game.object.GameObjectLayer;
	import game.object.GameObjectPool;
	import game.object.Player;
	import game.object.Takara;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Root extends Sprite
	{
		// 4:3
		public static const STAGE_WIDTH:uint = 1080;
		public static const STAGE_HEIGHT:uint = 1440;
		
		private var objPool:GameObjectPool;
		
		public function Root()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ROOT_CREATED, onAddedToStage);
			
			Input.registerListener(this);
			
			objPool = new GameObjectPool(this);
			
			objPool.addObject(new BackGround(), GameObjectPool.LAYER_BG);
			objPool.addObject(new Player(), GameObjectPool.LAYER_PLAYER);
			
			for (var i:int = 0; i < 10; i++) 
			{
				var takara:Takara = new Takara();
				takara.x = Math.random() * Root.STAGE_WIDTH;
				takara.y = Math.random() * 500;
				objPool.addObject(takara, GameObjectPool.LAYER_TAKARA);
			}
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			objPool.run();
		}
	}
}
