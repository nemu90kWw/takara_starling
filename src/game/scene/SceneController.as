package game.scene
{
	public class SceneController
	{
		private var scene:SceneBase;
		
		public function SceneController(scene:SceneBase)
		{
			this.scene = scene;
			scene.root = this;
		}
		
		public function run():void
		{
			scene.main();
		}
		
		public function changeScene(nextScene:SceneBase):void
		{
			scene.dispose();
			
			nextScene.root = this;
			scene = nextScene;
		}
	}
}