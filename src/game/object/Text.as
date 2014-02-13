package game.object
{
	import game.core.Root;
	
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Text extends GameObject
	{
		private var textField:TextField;
		
		public function Text()
		{
			textField = new TextField(Root.STAGE_WIDTH, 100, "", "BitmapFont", 84);
			addChild(textField);
			
			textField.hAlign = HAlign.LEFT;
			textField.vAlign = VAlign.TOP;
		}
		
		public function get text():String
		{
			return textField.text;
		}

		public function set text(value:String):void
		{
			textField.text = value;
		}

	}
}