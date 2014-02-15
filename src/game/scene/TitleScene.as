package game.scene
{
	import game.core.Input;
	import game.core.MasterViewport;
	import game.object.BackGround;
	import game.object.FadeOut;
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
		
		private var decide:Boolean;
		
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
			credit.y = MasterViewport.currentViewport.bottom - 60;
			credit.size = 64;
			objPool.addObject(credit, GameObjectPool.LAYER_MESSAGE);
			
			decide = false;
		}
		
		override public function main():void
		{
			if(decide == false)
			{
				if(Input.down == true)
				{
					decide = true;
				}
			}
			
			if(decide == true)
			{
				if(count % 4 < 2) {
					startButton.visible = false;
				}
				else {
					startButton.visible = true;
				}
				
				if(count == 30)
				{
					startButton.vanish();
					objPool.addObject(new FadeOut(), GameObjectPool.LAYER_SCREEN);
				}
				
				if(count == 80)
				{
					root.changeScene(new MainGameScene(target));
					return;
				}
				
				count++;
			}
			
			objPool.run();
		}
	}
}