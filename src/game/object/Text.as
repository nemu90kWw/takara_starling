package game.object
{
	import game.core.MasterViewPort;
	
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Text extends GameObject
	{
		private var textField:TextField;
		
		public function Text()
		{
			textField = new TextField(MasterViewPort.STAGE_WIDTH, 200, "", "Caslon", 144);
			addChild(textField);
			
			textField.hAlign = HAlign.LEFT;
			textField.vAlign = VAlign.TOP;
		}
		
		// --------------------------------//
		// プロパティの委譲
		// --------------------------------//
		public function get text():String
		{
			return textField.text;
		}
		
		public function set text(value:String):void
		{
			textField.text = value;
		}
		
		public function get size():Number
		{
			return textField.fontSize;
		}
		
		public function set size(value:Number):void
		{
			textField.fontSize = value;
		}
		
		public function get hAlign():String
		{
			return textField.hAlign;
		}
		
		public function set hAlign(value:String):void
		{
			textField.hAlign = value;
		}
		
		public function get vAlign():String
		{
			return textField.vAlign;
		}
		
		public function set vAlign(value:String):void
		{
			textField.vAlign = value;
		}
	}
}