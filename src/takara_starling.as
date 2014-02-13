package
{
	import flash.display.Sprite;
	import flash.display3D.Context3DBlendFactor;
	import flash.geom.Rectangle;
	
	import game.core.Root;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(frameRate="60", backgroundColor="#000000"]
	public class takara_starling extends Sprite
	{
		private var star:Starling;
		
		public function takara_starling()
		{
			// ブレンドに減算半透明を追加
			BlendMode.register("subtract", Context3DBlendFactor.ZERO, Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
			
			// 黒帯付きで拡大
			var viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, Root.STAGE_WIDTH, Root.STAGE_HEIGHT),
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
				ScaleMode.SHOW_ALL
			);
			
			star = new Starling(Root, stage, viewPort);
			star.stage.stageWidth = Root.STAGE_WIDTH;
			star.stage.stageHeight = Root.STAGE_HEIGHT;
			star.start();
			
			star.showStats = true;
			star.showStatsAt("left", "top", 2);
		}
	}
}
