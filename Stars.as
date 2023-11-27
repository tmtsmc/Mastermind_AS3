package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
 
	public class Stars extends MovieClip {
	private var star:Sprite;
	private var dalpha:Number;
		public function Stars() {
			star = new Sprite();
			star.x = Math.random() * 550;
			star.y = Math.random() * 400;
			star.alpha = Math.random();
			(Math.random() < 0.5) ? dalpha = 0.05 : dalpha = -0.05
			if (Math.random() < 1/3) {
				star.graphics.beginFill(0xaaffff);
			} else if (Math.random() > 2 / 3) {
				star.graphics.beginFill(0xaaaaff);
			} else {
				star.graphics.beginFill(0xffffff);
			}
			star.graphics.drawRect(0, 0, 2, 2);
			star.graphics.endFill();
			addChild(star);
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		public function update(e:Event):void {
			if (star.alpha + dalpha < 0) {
				star.alpha = 0;
				star.x = Math.random() * 550;
				star.y = Math.random() * 400;
				dalpha = -dalpha;
			}
			if (star.alpha + dalpha > 1) {
				star.alpha = 1;
				dalpha = -dalpha;
			} else {
				star.alpha += dalpha;
			}
		}
		
		public function die():void {
			removeEventListener(Event.ENTER_FRAME, update);
		}
	}
}
