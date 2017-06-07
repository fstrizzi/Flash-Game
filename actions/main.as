package actions {
	
	/*
	always extend a class using movieclip instead of sprite when using flash.
	*/

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.filters.*;
	import flash.geom.Rectangle;
	import flash.external.ExternalInterface;
	import com.greensock.*;
	import com.greensock.easing.*;
	import be.viplib.util.*;

	/*
	create our class
	*/
	
	public class main extends MovieClip {
		
	/*define variables*/
	public var material = "concrete_mc";
	public var sGame = 0;
	public var instantWinner = false;
	public var value1;
	public var value2;
	public var value3;
	public var boxes = 0;
	public var duration = randomRange(1200, 2300);
	public var time = duration/1000;
	public var totalScore:int = 0;
	public var container_mc:MovieClip;
	public var scores_text:TextField;
	public var xml_scores;
	public var xml_users;
	
	public var myXMLLoader:URLLoader = new URLLoader();
	public var my_images:XMLList;
	public var my_total:Number;
	public var current_user:XMLList;
	
	public var my_score;
	public var myScore;
	public var my_thumb;
	public var thumb_url;
	public var current_url;
	
	public var filter = new DropShadowFilter(4,45,20,0.5, 5.0, 5.0,1.0);
	
	var i:int;
	//the current page we're on
	var page:int = 1;
	//the limit of values we need per page
	var limit:int = 10;
	//the current row that we're working on
	var row:int = 0;
	//The total pages that we have
	var totalPages;
		
	public var validator:FormValidator;
	
	public var prices;
	
	public var priceNum1;
	
	public var priceNum2;
	
	public var instant = Math.ceil(Math.random()*5);
	
	/*end variables*/
	
	/*start main function*/
		public function main():void {
			
			/*******************************/
			userid.text = "";
			/*******************************/
			
		scanner_mc.visible = false;
			
		wood_btn.addEventListener(MouseEvent.CLICK, wood);
		tile_btn.addEventListener(MouseEvent.CLICK, tile); 
		marble_btn.addEventListener(MouseEvent.CLICK, marble); 
		drywall_btn.addEventListener(MouseEvent.CLICK, drywall); 
		concrete_btn.addEventListener(MouseEvent.CLICK, concrete);
				
		//BOTON PRINCIPAL
		intro_mc.intro_btn.addEventListener( MouseEvent.CLICK, startAll);
		
		play_btn.addEventListener( MouseEvent.CLICK, startAll);
		
		share_btn.addEventListener(MouseEvent.CLICK, shareFacebook);
		
		btn.addEventListener(MouseEvent.CLICK, demo);
		
		//btn.addEventListener(MouseEvent.CLICK, startAll);
		//btn.addEventListener(MouseEvent.CLICK, processDate);
		
		btn5.addEventListener(MouseEvent.CLICK, instantForm);
			
		ranMaterial();
			
		ExternalInterface.addCallback("sendTextFromJS", receiveTextFromJS);
			
		result_text.text = "";
			
		msg.visible = false;
				
		form_mc.visible = false;
		
		thanks_mc.visible = false;
		
		already.visible = false;
		
        }
		
		public function demo(e:MouseEvent) {
			sGame = 1;
			startGame();
			//processDate(null);
			instantWinner = true;
		}
		//RUN SCANNER
		public function runScanner():void {
			if (instantWinner == true) {
				prices = instant;
			} else if (instantWinner == false) {
				prices = Math.ceil(Math.random()*5);
				if (priceNum1 == prices) {
					prices = Math.ceil(Math.random()*5);
				}
			}
				switch(prices) {
					case 1:
						TweenMax.to(scanner_mc, time, {x:scanner_mc.x - 250, y:scanner_mc.y, ease:Quart.easeInOut, onComplete:function(){findItem(NonFerrous_mc, NonFerrous_scan_mc);}});
						break;
					case 2:
						TweenMax.to(scanner_mc, time, {x:scanner_mc.x - 250, y:scanner_mc.y, ease:Quart.easeInOut, onComplete:function(){findItem(Ferrous_mc, Ferrous_scan_mc);}});
						break;
					case 3:
						TweenMax.to(scanner_mc, time, {x:scanner_mc.x - 250, y:scanner_mc.y, ease:Quart.easeInOut, onComplete:function(){findItem(Pvc_mc, Pvc_scan_mc);}});
						break
					case 4:
						TweenMax.to(scanner_mc, time, {x:scanner_mc.x - 250, y:scanner_mc.y, ease:Quart.easeInOut, onComplete:function(){findItem(LiveElectric_mc, LiveElectric_scan_mc);}});
						break;
					case 5:
						TweenMax.to(scanner_mc, time, {x:scanner_mc.x - 250, y:scanner_mc.y, ease:Quart.easeInOut, onComplete:function(){findItem(WoodStud_mc, WoodStud_scan_mc);}});
						break;
				}
		}
		
		//FIND ITEM FUNCTION
		public function findItem(item, icons):void {
			var price1:MovieClip = MovieClip(price_box_1_mc.getChildByName("price-1"));
			var price2:MovieClip = MovieClip(price_box_2_mc.getChildByName("price-2"));
			var price3:MovieClip = MovieClip(price_box_3_mc.getChildByName("price-3"));
			var icono1:MovieClip = MovieClip(scanner_mc.icon_container_mc.getChildByName("icono-1"));
			var icono2:MovieClip = MovieClip(scanner_mc.icon_container_mc.getChildByName("icono-2"));
			var icono3:MovieClip = MovieClip(scanner_mc.icon_container_mc.getChildByName("icono-3"));
				if (price1 == null) {
					var item1:MovieClip = new item();
					price_box_1_mc.addChild(item1);
					item1.name = "price-1";
					value1 = item;
					boxes += 1;
					priceNum1 = prices;
					trace ("Numero 1: "+ priceNum1);
					//
					var icon1:MovieClip = new icons();
					scanner_mc.icon_container_mc.addChild(icon1);
					icon1.name = "icono-1";
					//
					runScanner();
				} else if (price1 != null && price2 == null) {
					var item2:MovieClip = new item();
					price_box_2_mc.addChild(item2);
					item2.name = "price-2";
					//trace ("box 2");
					value2 = item;
					boxes += 1;
					priceNum2 = prices;
					trace ("Numero 2: "+ priceNum2);
					//
					var icon2:MovieClip = new icons();
					scanner_mc.icon_container_mc.addChild(icon2);
					icon2.name = "icono-2";
					//
					runScanner();
				} else if (price1 != null && price2 != null && price3 == null) {
					var item3:MovieClip = new item();
					price_box_3_mc.addChild(item3);
					item3.name = "price-3";
					value3 = item;
					boxes += 1;
					//
					var icon3:MovieClip = new icons();
					scanner_mc.icon_container_mc.addChild(icon3);
					icon3.name = "icono-3";
					//
					checkPrice();
					trace ("Check Price");
				}
		}
		
		//CHECKPRICE
		public function checkPrice():void {
			if (instantWinner == true) {
				trace ("Check Instant");
				instantForm(null);
				stopGame(null);
				totalScore = 25;
				setTimeout(cleanBoxes, 1200);
				boxes = 0;
				saveScore();
			}
			if (instantWinner == false) {
				trace ("Check No Instant");
				stopGame(null);
				setTimeout(showMessage, 1200);
				setTimeout(cleanBoxes, 1200);
				//trace (_totalScore);
				if (value1 == value2 && value1 == value3) {
					trace ("los 3 iguales");
					totalScore = 100;
					boxes = 0;
					saveScore();
				} else if (value1 == value2 || value1 == value3 || value2 == value3) {
					trace ("2 iguales");
					totalScore = 50;
					boxes = 0;
					saveScore();
				}
				else {
					totalScore = 0;
					boxes = 0;
					saveScore();
				}
			}
		}
		
		//STOPGAME
		public function stopGame(evt:MouseEvent):void {
			TweenMax.to(scanner_mc, 2, {x:-50, y:scanner_mc.y, ease:Quart.easeInOut, onComplete:function() { /* */ }});
			trace("Stop Game");
		}
		
		//STARTGAME
		public function startGame():void {
			if (sGame == 1) {
				if (thanks_mc.visible == true) {
					closeThanks(null);
				}
				scanner_mc.visible = true;
				intro_mc.visible = false;
				TweenMax.to(scanner_mc, 4.5, {x:950, y:scanner_mc.y, ease:Quart.easeInOut, onComplete:function() {/*runScanner();*/}});
				TweenMax.delayedCall(3.7, runScanner);
				totalScore = 0;
			}
		}
		
		public function playAgainBtn(e:MouseEvent):void
		{
			ranMaterial();
			
			if (thanks_mc.visible == true) {
				closeThanks(null);
			}
			
			trace ("Play Again");
			//removeValues();
			msg.visible = false;
			msg.btn.removeEventListener(MouseEvent.MOUSE_DOWN, windowBtn);
			msg.playbtn.removeEventListener(MouseEvent.MOUSE_DOWN, playAgainBtn);
						
			intro_mc.visible = false;
			
			already.visible = false;

			if (sGame == 1) {
				processDate(null);
			} else {
				startAll(null);
			}
		}

		
		//SHOWMESSAGE
		public function showMessage():void {
			msg.totalScore_txt.text = totalScore;
			msg.visible = true;
			msg.btn.addEventListener(MouseEvent.MOUSE_DOWN, windowBtn);
			msg.playbtn.addEventListener(MouseEvent.MOUSE_DOWN, playAgainBtn);
			//disableAll(null);
			msg.alpha = 100;
			trace (totalScore);
			msg.share_btn.addEventListener(MouseEvent.CLICK, shareFacebook);
		}
		
		public function windowBtn(e:MouseEvent):void
		{
			msg.visible = false;
			msg.btn.removeEventListener(MouseEvent.MOUSE_DOWN, windowBtn);
			msg.playbtn.removeEventListener(MouseEvent.MOUSE_DOWN, playAgainBtn);
			msg.share_btn.removeEventListener(MouseEvent.CLICK, shareFacebook);
			intro_mc.visible = true;
		}
		
		//SHOWAlready
		public function showAlready():void {
			already.visible = true;
			already.closebtn.addEventListener(MouseEvent.MOUSE_DOWN, closeAlready);
			//disableAll(null);
			already.alpha = 100;
			trace (totalScore);
			already.share_btn.addEventListener(MouseEvent.CLICK, shareFacebook);
		}
		
		public function closeAlready(e:MouseEvent):void
		{
			already.visible = false;
			already.closebtn.removeEventListener(MouseEvent.MOUSE_DOWN, closeAlready);
			already.share_btn.removeEventListener(MouseEvent.CLICK, shareFacebook);
			intro_mc.visible = true;
		}
		
		//PHP FUNCTION
		public function processDate(evt:MouseEvent):void {
			
			trace ("Check Date");
	
			var phpVars:URLVariables = new URLVariables();
					
			var phpFileRequest:URLRequest = new URLRequest("app/select.php");
			//var phpFileRequest:URLRequest = new URLRequest("http://localhost/em/dewalt/app/select.php");

			phpFileRequest.method = URLRequestMethod.POST;
			
			phpFileRequest.data = phpVars;
			
			var phpLoader:URLLoader = new URLLoader();
			phpLoader.dataFormat = URLLoaderDataFormat.VARIABLES;			
			phpLoader.addEventListener(Event.COMPLETE, showResult);
			
			phpVars.systemCall = "checkDate";
			phpVars.userid = userid.text;
			
			phpLoader.load(phpFileRequest);
		
		}
				
		public function showResult(evt:Event):void {
			
			if (evt.target.data.systemResult == "normal") {
				result_text.text = "" + evt.target.data.systemResult;
				instantWinner = false;
			}
			if (evt.target.data.systemResult == "instant") {
				result_text.text = "" + evt.target.data.systemResult;
				instantWinner = true;
			}
			if (evt.target.data.alreadyPlayed == "false") {
				startGame();
				result_text.text = "Start";
			}
			if (evt.target.data.alreadyPlayed == "true") {
				trace ("you already played today");
				showAlready();
			}
		}
		
		/* function we use to send the form */
		
		public function saveScore():void {
			
			var phpVars:URLVariables = new URLVariables();
			
			phpVars.user_id = userid.text;
			phpVars.email = "email";
			phpVars.score = totalScore;
			
			var urlRequest:URLRequest = new URLRequest("app/savescore.php");
			//var urlRequest:URLRequest = new URLRequest("http://localhost/em/dewalt/app/savescore.php");
			
			urlRequest.method = URLRequestMethod.POST;
			
			urlRequest.data = phpVars;
			
			phpVars.systemCall = "saveScore";
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			urlLoader.load(urlRequest);
			
		}
		
		public function instantForm(evt:MouseEvent):void {
			form_mc.fname.tabIndex = 1;
			form_mc.lname.tabIndex = 2;
			form_mc.email.tabIndex = 3;
			form_mc.visible = true;
			form_mc.alpha = 100;
			validator=new FormValidator(form_mc,["fname","lname","email"],["email"],0x000000,0xff0000,"Please, complete this field","Please complete with a valid email");			
			form_mc.submit_btn.addEventListener(MouseEvent.CLICK, validateButtonClicked_handler);
			form_mc.close_btn.addEventListener(MouseEvent.CLICK, closeForm);
			form_mc.share_btn.addEventListener(MouseEvent.CLICK, shareInstant);
			//instantWinner = false;
		}
		
		public function closeForm(evt:MouseEvent):void {
			form_mc.visible = false;
			intro_mc.visible = true;
			form_mc.submit_btn.removeEventListener(MouseEvent.CLICK, validateButtonClicked_handler);
			form_mc.close_btn.removeEventListener(MouseEvent.CLICK, closeForm);
			form_mc.share_btn.removeEventListener(MouseEvent.CLICK, shareInstant);
		}
		
		public function validateButtonClicked_handler(evt:MouseEvent):void{
			//var resultField:TextField=pepe.getChildByName("result_txt") as TextField;
			if(validator.validate()){
				trace ("yes");
				sendForm();
			}else{
				trace ("no");
			}
		}
		
		public function completeHandler(event:Event):void {
			closeForm(null);
			thanks_mc.visible = true;
			thanks_mc.alpha = 100;
			//thanks_mc.playbtn.addEventListener(MouseEvent.MOUSE_DOWN, playAgainBtn);
			thanks_mc.close.addEventListener(MouseEvent.MOUSE_DOWN, closeThanks);
			thanks_mc.share_btn.addEventListener(MouseEvent.CLICK, shareInstant);
		}
		
		public function closeThanks(evt:MouseEvent):void {
			//thanks_mc.playbtn.removeEventListener(MouseEvent.MOUSE_DOWN, playAgainBtn);
			thanks_mc.close.removeEventListener(MouseEvent.MOUSE_DOWN, closeThanks);
			thanks_mc.visible = false;
			thanks_mc.share_btn.removeEventListener(MouseEvent.CLICK, shareInstant);
		}
		
		public function sendForm():void {
			form_mc.submit_btn.removeEventListener(MouseEvent.CLICK, validateButtonClicked_handler);
			var variables:URLVariables = new URLVariables();
			variables.fname = form_mc.fname.text;
			variables.lname = form_mc.lname.text;
			variables.email = form_mc.email.text;
			var request:URLRequest = new URLRequest();
			//request.url = "http://localhost/em/dewalt/app/savesInstant.php";
			request.url = "app/savesInstant.php";
			request.method = URLRequestMethod.POST;
			request.data = variables;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, completeHandler);
			try {
				loader.load(request);
			} catch (error:Error) {
				trace ("error");
				//txError.text="Unable to load URL";
			}
		}
		
		//CLEANBOXES
		public function cleanBoxes():void {
			var item1:MovieClip = MovieClip(price_box_1_mc.getChildByName("price-1"));
			var item2:MovieClip = MovieClip(price_box_2_mc.getChildByName("price-2"));
			var item3:MovieClip = MovieClip(price_box_3_mc.getChildByName("price-3"));

			price_box_1_mc.removeChild(item1);
			price_box_2_mc.removeChild(item2);
			price_box_3_mc.removeChild(item3);

			var icono1:MovieClip = MovieClip(scanner_mc.icon_container_mc.getChildByName("icono-1"));
			var icono2:MovieClip = MovieClip(scanner_mc.icon_container_mc.getChildByName("icono-2"));
			var icono3:MovieClip = MovieClip(scanner_mc.icon_container_mc.getChildByName("icono-3"));
			
			scanner_mc.icon_container_mc.removeChild(icono1);
			scanner_mc.icon_container_mc.removeChild(icono2);
			scanner_mc.icon_container_mc.removeChild(icono3);

			trace ("clean box");
		}
		
		//RANDOM RANGE
		public function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		//FACEBOOK JS SEND AND RECEIVE
		public function startAll(evt:MouseEvent):void {
			trace("Check Facebook");
			sendTextFromAS3();
		}
		
		//Set up Javascript to Actioscript
		public function receiveTextFromJS(t:String, Game:String):void {
			userid.text = t;
			sGame = Game;
				processDate(null);
		}
		
		//Actionscript to Javascript
		public function sendTextFromAS3():void {
			ExternalInterface.call("receiveTextFromAS3");
			//result_text.text = "";
		}
		
		//Share Score on Facebook
		public function shareFacebook(evt:MouseEvent):void {
			ExternalInterface.call("publishStream", totalScore);
			//result_text.text = "";
		}
		public function shareInstant(evt:MouseEvent):void {
			ExternalInterface.call("publishInstant");
			//result_text.text = "";
		}
		
		//RAN MATERIAL
		public function ranMaterial():void {
			material = Math.ceil(Math.random()*5);
			switch(material) {
				case 1:
					trace("concrete");
					addMaterial(concrete_mc);
					break;
				case 2:
					trace("wood");
					addMaterial(wood_mc);
					break;
				case 3:
					trace("tile");
					addMaterial(tile_mc);
					break
				case 4:
					trace("marble");
					addMaterial(marble_mc);
					break;
				case 5:
					trace("drywall");
					addMaterial(drywall_mc);
					break;
			}
			
		}
		
		// MATERIALS //
		public function addMaterial(material):void {
			
			//This adds two instances of the movie clip onto the stage.
			var s1:MovieClip = new material();
			var s2:MovieClip = new material();
			
			materials_container.addChild(s1); 
			materials_container.addChild(s2);
			
			s1.name = "material-1";
			s2.name = "material-2";
			
			s1.x = 0;
			s2.x = s1.width;
						
		}
		
		private function removeMaterial():void {
			var s1:MovieClip = MovieClip(materials_container.getChildByName("material-1"));
			var s2:MovieClip = MovieClip(materials_container.getChildByName("material-2"));
			materials_container.removeChild(s1);
			materials_container.removeChild(s2);
		}
				
		private function wood(evt:MouseEvent):void {
			trace ("wood");
			removeMaterial();
			addMaterial(wood_mc);
		}
		
		private function tile(evt:MouseEvent):void {
			trace ("tile");
			removeMaterial();
			addMaterial(tile_mc);
		}
		
		private function marble(evt:MouseEvent):void {
			trace ("marble");
			removeMaterial();
			addMaterial(marble_mc);
		}
		
		private function drywall(evt:MouseEvent):void {
			trace ("drywall");
			removeMaterial();
			addMaterial(drywall_mc);
		}
		
		private function concrete(evt:MouseEvent):void {
			trace ("concrete");
			removeMaterial();
			addMaterial(concrete_mc);
		}
		
		//FUNCTION TRACE
		public function traceMc(e:MouseEvent):void {
			trace ("trace");
			//for (var i:uint = 0; i < leader_mc.numChildren; i++){
				//trace ('\t|\t ' +i+'.\t name:' + leader_mc.getChildAt(i).name + '\t type:' + typeof (leader_mc.getChildAt(i))+ '\t' + leader_mc.getChildAt(i));
			//}
			trace (myXMLLoader);
		}
	
	/********************************************************/
	}

}