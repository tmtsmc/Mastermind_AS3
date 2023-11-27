package {
	import flash.display.MovieClip;
	
	public class Square extends MovieClip {
		private var position:Number = 0;
		private var size:Number;
		
		public function Square(posX:Number, posY:Number, little:Boolean = false, caca:Boolean = false, size:Number = 36, color:Number = 1) {
			if (little) {
				this.graphics.beginFill(0x1D1D22);
				this.graphics.drawCircle(Main.LITTLESIZE / 2, Main.LITTLESIZE / 2, Main.LITTLESIZE / 2);
			} else if (caca) {
				if (color == 1) { // switch
				this.graphics.beginFill(0xFF0000);
				} else if (color == 2) {
					this.graphics.beginFill(0x00FF00);
				} else if (color == 3) {
					this.graphics.beginFill(0x0000FF);
				} else if (color == 4) {
					this.graphics.beginFill(0xFFFF00);
				} else if (color == 5) {
					this.graphics.beginFill(0x00FFFF);
				} else if (color == 6) {
					this.graphics.beginFill(0xFF00FF);
				}
				this.graphics.drawCircle(size / 2, size / 2, size / 2);
			} else {
				this.graphics.beginFill(0x000000);
				this.graphics.drawCircle(size / 2, size / 2, size / 2);
			}
			this.x = posX;
			this.y = posY;
		}
		
		public function change():void {
			this.graphics.clear();
			if (position + 1 == 7) position = 1;
			else position++;
			if (position == 1) { // switch
				this.graphics.beginFill(0xFF0000);
			} else if (position == 2) {
				this.graphics.beginFill(0x00FF00);
			} else if (position == 3) {
				this.graphics.beginFill(0x0000FF);
			} else if (position == 4) {
				this.graphics.beginFill(0xFFFF00);
			} else if (position == 5) {
				this.graphics.beginFill(0x00FFFF);
			} else if (position == 6) {
				this.graphics.beginFill(0xFF00FF);
			}
			this.graphics.drawCircle(Main.SIZE / 2, Main.SIZE / 2, Main.SIZE / 2);
		}
		
		public function getPosition():Number {
			return position;
		}
		
		public function success():void {
			this.graphics.clear();
			this.graphics.beginFill(0xAA0000);
			this.graphics.drawCircle(Main.LITTLESIZE / 2, Main.LITTLESIZE / 2, Main.LITTLESIZE / 2);
		}
		
		public function almost():void {
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawCircle(Main.LITTLESIZE / 2, Main.LITTLESIZE / 2, Main.LITTLESIZE / 2);
		}
		
		public function select():void {
			this.graphics.clear();
			this.graphics.beginFill(0x101030);
			this.graphics.drawCircle(Main.SIZE / 2, Main.SIZE / 2, Main.SIZE / 2);
		}
	}
}
