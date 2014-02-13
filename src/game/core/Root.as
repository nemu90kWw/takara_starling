package game.core
{
	import game.scene.MainGameScene;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Root extends Sprite
	{
		// 4:3
		public static const STAGE_WIDTH:uint = 1080;
		public static const STAGE_HEIGHT:uint = 1440;
		private var scene:MainGameScene;
		
		public function Root()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ROOT_CREATED, onAddedToStage);
			
			Input.registerListener(this);
			
			scene = new MainGameScene(this);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			scene.main();
		}
	}
}
