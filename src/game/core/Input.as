package game.core
{
	import starling.display.Stage;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Input
	{
		public static var touchX:Number = 0;
		public static var touchY:Number = 0;
		
		public static var down:Boolean = false;
		
		public static function registerListener(listener:Stage):void
		{
			listener.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private static function onTouch(e:TouchEvent):void
		{
			switch(e.touches[0].phase)
			{
			case TouchPhase.BEGAN:
				touchX = e.touches[0].globalX / MasterViewport.scale;
				touchY = e.touches[0].globalY / MasterViewport.scale;
				down = true;
				break;
			case TouchPhase.MOVED:
				touchX = e.touches[0].globalX / MasterViewport.scale;
				touchY = e.touches[0].globalY / MasterViewport.scale;
				break;
			case TouchPhase.ENDED:
				down = false;
				break;
			}
		}
	}
}