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
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			objPool.run();
		}
	}
}
