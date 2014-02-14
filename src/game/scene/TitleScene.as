package game.scene
{
	import game.core.Input;
	import game.object.BackGround;
	import game.object.GameObjectPool;
	import game.object.Text;
	import game.object.TitleLogo;
	
	import starling.display.Sprite;
	import starling.utils.HAlign;
	
	public class TitleScene extends SceneBase
	{
		private var logo:TitleLogo;
		private var startButton:Text;
		private var credit:Text;
		
		public function TitleScene(target:Sprite)
		{
			super(target);
			objPool.addObject(new BackGround(), GameObjectPool.LAYER_BG);
			
			logo = new TitleLogo();
			logo.x = 90;
			logo.y = 180;
			
			objPool.addObject(logo, GameObjectPool.LAYER_MESSAGE);
			
			startButton = new Text();
			startButton.text = "TAP TO START";
			startButton.hAlign = HAlign.CENTER;
			startButton.y = 900;
			
			objPool.addObject(startButton, GameObjectPool.LAYER_MESSAGE);
			
			credit = new Text();
			credit.text = "(C)nemu90kWw.";
			credit.hAlign = HAlign.RIGHT;
			credit.y = 1360;
			credit.size = 42;
			
			objPool.addObject(credit, GameObjectPool.LAYER_MESSAGE);
		}
		
		override public function main():void
		{
			if(Input.down == true)
			{
				root.changeScene(new MainGameScene(target));
			}
			count++;
		}
	}
}