package
{
	import flash.display.Sprite;
	import starling.core.Starling;
	
	public class takara_starling extends Sprite
	{
		private var star:Starling;
		public function takara_starling()
		{
			star = new Starling(Root, stage);
			star.start();
		}
	}
}
import starling.display.Sprite;

class Root extends Sprite
{
	public function Root()
	{
		
	}
}