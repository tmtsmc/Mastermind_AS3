package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Mouse;
	//import flash.media.Sound;
	//import flash.media.SoundChannel;
	import flash.text.TextField;
	import mochi.as3.MochiServices;
	import mochi.as3.MochiScores;
	
	public class Board extends MovieClip {
		private var caca:Boolean = true;
		private var i:int, j:int;
		private var life:Number, victory:Number = 0, almost:Number = 0;
		private var kh:Number = 0, jh:Number = 0, ih:Number = 0;
		private var spriteBoard:Sprite;
		private var text:TextField, link:TextField;
		private var column:Number, line:Number, posX:Number, posY:Number;
		private var stars:Array;
		private var map:Array = new Array();
		private var tips:Array = new Array();
		private var answer:Array = new Array();
		private var copyMap:Array = new Array();
		private var copyAnswer:Array = new Array();
		//private	var chanel:SoundChannel = new SoundChannel();
		//[Embed(source = "fail.mp3")] private var soundFail:Class;
		//[Embed(source = "win.mp3")] private var soundWin:Class;
		//[Embed(source = "ChaosRings.mp3")] private var soundAmbiant:Class;
		
		public function Board(column:Number = 4, line:Number = 7) {
			this.column = column;
			this.line = line;
			this.life = line;
			stars = new Array();
			for (var m:int = 0; m < 100; m++) {
				stars.push(new Stars());
				addChild(stars[m]);
			}
			text = new TextField();
			text.text = " ";
			text.x = 20;
			text.y = 170;
			addEventListener(Event.ENTER_FRAME, timeFunction, false, 0, true);
			addEventListener(MouseEvent.CLICK, click);
			addChild(text);
			//soundWin.load(new URLRequest("win.mp3"));
			//soundFail.load(new URLRequest("fail.mp3"));
			//chanel = (new soundAmbiant()).play();
			spriteBoard = new Sprite();
			spriteBoard.graphics.beginFill(0xAAAADD);
			spriteBoard.graphics.drawRoundRect(0, 0, (Main.GAP + Main.SIZE) * column + Main.GAP, (Main.GAP + Main.SIZE) * line + Main.GAP, 15, 15);
			spriteBoard.x = (Main.WIDTH - ((Main.GAP + Main.SIZE) * column + Main.GAP)) / 2;
			spriteBoard.y = (Main.HEIGHT - ((Main.GAP + Main.SIZE) * line + Main.GAP)) / 2;
			addChild(spriteBoard);
			link = new TextField();
			link.text = "www.tmtsmc.comze.com";
			link.x = spriteBoard.x + 35;
			link.y = spriteBoard.y + (Main.GAP + Main.SIZE) * line + Main.GAP - 2;
			link.width = 150;
			link.height = 20;
			link.textColor = 0x000000;
			addChild(link);
			for (i = 0; i < line; i++) {
				map.push(new Array());
				tips.push(new Array());
				for (j = 0; j < column; j++) {
					copyAnswer.push(0);
					copyMap.push(0);
					answer.push(Math.floor(Math.random() * 6 + 1));
					map[i].push(new Square(spriteBoard.x + Main.GAP + (Main.GAP + Main.SIZE) * j, spriteBoard.y + Main.GAP + (Main.GAP + Main.SIZE) * i));
					tips[i].push(new Square(spriteBoard.x + Main.GAP + Main.LITTLEGAP + (Main.GAP + Main.SIZE) * column + Main.GAP + (Main.LITTLEGAP + Main.LITTLESIZE) * j, spriteBoard.y + Main.GAP + Main.LITTLEGAP + (Main.GAP + Main.SIZE) * i, true));
					addChild(map[i][j]);
					addChild(tips[i][j]);
					if (i == line - 1) {
						map[i][j].addEventListener(MouseEvent.CLICK, change);
						map[i][j].select();
					}
				}
			}
			text.text = "";
		}
		
		private function timeFunction(e:Event):void {
			kh++;
			if (kh == 30) {
				kh = 0;
				ih++;
				if (ih == 60) {
					ih = 0;
					jh++;
				}
			}
			if (link.hitTestPoint(mouseX, mouseY)) Mouse.cursor = "button";
			else Mouse.cursor = "arrow";
		}
		
		private function click(e:Event):void {
			if (link.hitTestPoint(mouseX, mouseY)) navigateToURL(new URLRequest("http://www.tmtsmc.comze.com"));
		}
		
		private function change(e:MouseEvent):void {
			e.target.change();
		}
		
		public function listener():void {
			if (caca) {
				for (i = 0; i < line; i++) {
					for (j = 0; j < column; j++) {
						if (i + 1 == life) {
							map[i][j].removeEventListener(MouseEvent.CLICK, change);
						} else if (i + 2 == life) {
							map[i][j].addEventListener(MouseEvent.CLICK, change);
							map[i][j].select();
						}
					}
				}
				for (i = 0; i < column; i++) {
					copyAnswer[i] = answer[i];
					copyMap[i] = map[life - 1][i].getPosition();
				}
				for (j = 0; j < column; j++) {
					if (map[life - 1][j].getPosition() == copyAnswer[j]) {
						copyAnswer[j] = -1;
						copyMap[j] = -2;
						victory++;
					} 
				}
				for (j = 0; j < column; j++) {
					for (var k:uint = 0; k < column; k++) {
						if (copyMap[j] == copyAnswer[k]) {
								almost++;
								copyAnswer[k] = -1;
								k = 4;
						}
					}
				}
				for (i = 0; i < victory; i++) tips[life - 1][i].success();
				for (i = victory; i < almost + victory; i++) tips[life - 1][i].almost();
				if (victory == 4) {
					//chanel.stop();
					//chanel = (new soundWin()).play();
					caca = false;
					text.text = "Time :  " + jh + ":" + ih;
					MochiServices.connect("6f896b873c38fe40", this);
					MochiScores.showLeaderboard( { boardID:"a3e3e4d5fe821ed2" , score:(ih + jh * 60 + Math.round((kh / 30)*1000)/1000 + (kh / 30)) * 1000 } );
				} else if (life - 1 == 0) {
					//chanel.stop();
					//chanel = (new soundFail()).play();
					caca = false;
					life--;
					map.push(new Array());
					text.text = "The answer was :";
					for (var i:uint = 0; i < column; i++) {
						map[line].push(new Square(8 + i * 31, 200, false, true, 20, answer[i]));
						addChild(map[line][i]);
					}
				} else {
					life--;
					victory = 0;
					almost = 0;
				}
			}
		}
		
		public function getLife():Number {
			return life;
		}
	}
}
