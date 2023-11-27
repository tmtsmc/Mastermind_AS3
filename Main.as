package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import mochi.as3.MochiAd;
	import mochi.as3.MochiServices;
	import mochi.as3.MochiScores;

	public dynamic class Main extends MovieClip {
		private var _mochiads_game_id:String = "";
		public static const WIDTH:Number = 500;
		public static const HEIGHT:Number = 400;
		public static const SIZE:Number = 36;
		public static const LITTLESIZE:Number = 18;
		public static const GAP:Number = 15;
		public static const LITTLEGAP:Number = 5;
		private var menu:ContextMenu = new ContextMenu();
		private var spriteBoard:Board;
		private var submit:Submit;
		private var mastermind:TextField = new TextField(), author:TextField = new TextField(), life:TextField = new TextField();
		private var isAd:Boolean;
		
		public function Main():void {
			isAd = true;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// start !
			stop();
			addFrameScript(0, ad);
			addFrameScript(1, startGame);
			addFrameScript(2, leaderboard);
		}
		
		private function ad():void {
			//-frame frameN Main
			if (isAd) {
				MochiAd.showPreGameAd( { clip:this, id:_mochiads_game_id, res:"500x400" } );
			} else {
				stop();
				nextFrame();
			}
		}
		
		private function startGame():void {
			stop();
			menu = new ContextMenu();
			menu.hideBuiltInItems();
			this.contextMenu = menu;
			
			spriteBoard = new Board(4, 7);
			
			submit = new Submit();
			
			mastermind.text = "Mastermind AS3";
			mastermind.x = 25;
			mastermind.y = 50;
			//author.text = "tmtsmc";
			author.text = "tmtsmc";
			author.x = 25;
			author.y = 75;
			life.text = "Life : " + spriteBoard.getLife();
			life.x = 25;
			life.y = 100;
			
			if (isAd) {
				submit.addEventListener(MouseEvent.CLICK, clickSubmit);
				submit.addEventListener(MouseEvent.MOUSE_OVER, overSubmit);
				submit.addEventListener(MouseEvent.MOUSE_OUT, outSubmit);
				isAd = false;
			}
			
			addChild(spriteBoard);
			addChild(submit);
			addChild(mastermind);
			addChild(author);
			addChild(life);
		}
		
		private function leaderboard():void {
			MochiServices.connect(_mochiads_game_id, this);
			MochiScores.showLeaderboard( { boardID:_mochiads_game_id , score:1000 } );
		}
		
		private function clickSubmit(e:MouseEvent):void {
			spriteBoard.listener();
			life.text = "Life : " + spriteBoard.getLife();
		}
		
		private function overSubmit(e:MouseEvent):void {
			submit.over();
		}
		
		private function outSubmit(e:MouseEvent):void {
			submit.out();
		}
	}
}
