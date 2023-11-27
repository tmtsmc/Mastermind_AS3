package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Submit extends MovieClip {
		private var square:Sprite = new Sprite();
		private var text:TextField = new TextField();
		
		public function Submit() {
			text.text = "SUBMIT";
			text.width = 60;
			text.height = 20;
			text.selectable = false;
			text.x = 45;
			text.y = 340;
			square.graphics.beginFill(0x448844);
			square.graphics.drawRoundRect(0, 0, 100, 50, 15, 15);
			square.x = 20;
			square.y = 325;
			this.addChild(square);
			this.addChild(text);
		}
		
		public function over():void {
			square.graphics.clear();
			square.graphics.beginFill(0x60AA60);
			square.graphics.drawRoundRect(0, 0, 100, 50, 15, 15);
			this.addChild(square);
			this.addChild(text);
		}
		
		public function out():void {
			square.graphics.clear();
			square.graphics.beginFill(0x448844);
			square.graphics.drawRoundRect(0, 0, 100, 50, 15, 15);
			this.addChild(square);
			this.addChild(text);
		}
	}
}
