package game.core
{
	import game.resources.SpriteSheet;
	import game.scene.MainGameScene;
	import game.scene.SceneBase;
	import game.scene.SceneController;
	import game.scene.TitleScene;
	
	import starling.display.Sprite;
	import starling.events.Event;

	// Starlingで作成される本体
	public class MasterViewPort extends Sprite
	{
		// 4:3
		public static const STAGE_WIDTH:uint = 1080;
		public static const STAGE_HEIGHT:uint = 1440;
		private var scene:SceneController;
		
		public function MasterViewPort()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ROOT_CREATED, onAddedToStage);
			
			Input.registerListener(stage);
			
			SpriteSheet.registerBitmapFont();
			
			scene = new SceneController(new TitleScene(this));
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			scene.run();
		}
	}
}
