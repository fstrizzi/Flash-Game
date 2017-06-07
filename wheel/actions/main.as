package actions {
	
	/*
	always extend a class using movieclip instead of sprite when using flash.
	*/

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.filters.*;
	
	import flash.display.Sprite;
	import flash.display.Shape;

	import fl.data.DataProvider; 
	import fl.events.ComponentEvent; 
	
	//import be.calibrate.forms.validation.*;
	import be.viplib.util.*;
	
	/*
	create our class
	*/
	
	public class main extends MovieClip {
		
		/*
		define variables
		*/
		private var speed:Number = 0;
		private var paddles:Vector.<Sprite> = new Vector.<Sprite>();
		private var lastPaddle:String;
		private var hAreaX:Number;
		private var hAreaY:Number;
		var redirect:Boolean;
		private var price:Number;
		private var rate:Number = 0;
		private var acceleration:Number = 0.5;
		private var accelerate:Boolean = true;
		private var blurX:Number = 0;
		private var blurY:Number;
		private var blurInc:Number = 4;
		private var count:Number = 4;
		private var time:Number;
		private var myTimer:Timer = new Timer(1000, count);
		private var blur = new BlurFilter(blurX, blurY, 2);
		private var validator_msg_terms:String;
		
		
		public function main ():void {
			
			/*
			define paddles
			*/
			paddles.push(wheel.p1, wheel.p2, wheel.p3, wheel.p4, wheel.p5, wheel.p6, wheel.p7, wheel.p8, wheel.p9, wheel.p10, wheel.p11, wheel.p12, wheel.p13, wheel.p14, wheel.p15, wheel.p16, wheel.p17, wheel.p18);
			listeners('add');
			
			msg.visible = false;
			rules.visible = false;
			rules.alpha = 100;
			validator_msg.visible = false;
			validator_msg_terms = "<br><font size='12'>**You may need to scroll down through the form to fully complete your entry.</font>";
			
			/***** FILL COMBO *****/
			var states:Array = [ 
				{label:"Select your State", data:""},
				{label:"Alabama", data:"Alabama"},
				{label:"Alaska", data:"Alaska"},
				{label:"Arizona", data:"Arizona"},
				{label:"Arkansas", data:"Arkansas"},
				{label:"California", data:"California"},
				{label:"Colorado", data:"Colorado"},
				{label:"Connecticut", data:"Connecticut"},
				{label:"Delaware", data:"Delaware"},
				{label:"District of Columbia", data:"District of Columbia"},
				{label:"Florida", data:"Florida"},
				{label:"Georgia", data:"Georgia"},
				{label:"Hawaii", data:"Hawaii"},
				{label:"Idaho", data:"Idaho"},
				{label:"Illinois", data:"Illinois"},
				{label:"Indiana", data:"Indiana"},
				{label:"Iowa", data:"Iowa"},
				{label:"Kansas", data:"Kansas"},
				{label:"Kentucky", data:"Kentucky"},
				{label:"Louisiana", data:"Louisiana"},
				{label:"Maine", data:"Maine"},
				{label:"Maryland", data:"Maryland"},
				{label:"Massachusetts", data:"Massachusetts"},
				{label:"Michigan", data:"Michigan"},
				{label:"Minnesota", data:"Minnesota"},
				{label:"Mississippi", data:"Mississippi"},
				{label:"Missouri", data:"Missouri"},
				{label:"Montana", data:"Montana"},
				{label:"Nebraska", data:"Nebraska"},
				{label:"Nevada", data:"Nevada"},
				{label:"New Hampshire", data:"New Hampshire"},
				{label:"New Jersey", data:"New Jersey"},
				{label:"New Mexico", data:"New Mexico"},
				{label:"New York", data:"New York"},
				{label:"North Carolina", data:"North Carolina"},
				{label:"North Dakota", data:"North Dakota"},
				{label:"Ohio", data:"Ohio"},
				{label:"Oklahoma", data:"Oklahoma"},
				{label:"Oregon", data:"Oregon"},
				{label:"Pennsylvania", data:"Pennsylvania"},
				{label:"Puerto Rico", data:"Puerto Rico"},
				{label:"Rhode Island", data:"Rhode Island"},
				{label:"South Carolina", data:"South Carolina"},
				{label:"South Dakota", data:"South Dakota"},
				{label:"Tennessee", data:"Tennessee"},
				{label:"Texas", data:"Texas"},
				{label:"Utah", data:"Utah"},
				{label:"Vermont", data:"Vermont"},
				{label:"Virginia", data:"Virginia"},
				{label:"Virgin Islands", data:"Virgin Islands"},
				{label:"Washington", data:"Washington"},
				{label:"West Virginia", data:"West Virginia"},
				{label:"Wisconsin", data:"Wisconsin"},
				{label:"Wyoming", data:"Wyoming"},
			]; 
			combo.dataProvider = new DataProvider(states); 
			
			/***** END COMBO *****/

			/*
			buttonMode gives the submit button a rollover
			*/
			
			//submit_button.buttonMode = true;
			
			/*
			set the initial textfield values
			*/
			
			fname.text = "";
			fname.borderColor = 0xE51B24;
			fname.tabIndex = 1;
			
			lname.text = "";
			lname.borderColor = 0xE51B24;
			lname.tabIndex = 2;
			
			email.text = "";
			email.borderColor = 0xE51B24;
			email.tabIndex = 3;
			
			address.text = "";
			address.borderColor = 0xE51B24;
			address.tabIndex = 4;
			
			suite.text = "";
			suite.borderColor = 0xE51B24;
			suite.tabIndex = 5;
			
			city.text = "";
			city.borderColor = 0xE51B24;
			city.tabIndex = 6;
			
			combo.tabIndex = 7;
			
			zip.text = "";
			zip.borderColor = 0xE51B24;
			zip.tabIndex = 8;
			
			phone.text = "";
			phone.borderColor = 0xE51B24;
			phone.tabIndex = 9;
			
			suscribe.tabIndex = 10;
			
			signup.tabIndex = 11;
			
			terms.tabIndex = 12;
		}

		/*
		the function to check login
		*/
		
		public function checkLogin (e:MouseEvent):void {
		
			/*
			check fields before sending request to php
			*/
			
			var validator:FormValidator;

			validator=new FormValidator(this,["fname","lname","email", "address", "city", "zip"],["email"],["First Name","Last Name","Email", "Address", "City", "Zip Code"],0x000000,0x000000,"Email");
			
			if (combo.text == "Select your State") {
				combo_error.text = "State";
				combo.addEventListener(FocusEvent.FOCUS_IN,fieldFocus);
			}
			
			if (terms.selected != true) {
				terms_error.text = "Agree to the Official Rules";
				terms.addEventListener(FocusEvent.FOCUS_IN,fieldFocus);
			}
			
			function fieldFocus(evt:FocusEvent):void {
				combo_error.text = "";
				terms_error.text = "";
				combo.removeEventListener(FocusEvent.FOCUS_IN,fieldFocus);
				terms.removeEventListener(FocusEvent.FOCUS_IN,fieldFocus);
			}
			
			if(validator.validate()){
				if (combo.text != "Select your State" && terms.selected == true) {
					result_text.text = "campos validados";
					processLogin();
				}
				else {
					if (terms.selected == false) {
						terms_error.text = "Agree to the Official Rules";
					}
					if (combo.text == "Select your State") {
						combo_error.text = "State";
					}
					result_text.text = "campos no validados";
					showValidator(null);
				}
			}else{
				result_text.text="Not Ok";
				showValidator(null);
			}
		}
		
		/*
		function to process our login
		*/
		
		public function processLogin ():void {
			
			/*
			variables that we send to the php file
			*/
		
			var phpVars:URLVariables = new URLVariables();
			
			/*
			we create a URLRequest  variable. This gets the php file path.
			*/
			
			var phpFileRequest:URLRequest = new URLRequest("php/select.php");
			
			/*
			this allows us to use the post function in php
			*/
			
			phpFileRequest.method = URLRequestMethod.POST;
			
			/*
			attach the php variables to the URLRequest
			*/
			
			phpFileRequest.data = phpVars;
			
			/*
			create a new loader to load and send our urlrequest
			*/
			
			var phpLoader:URLLoader = new URLLoader();
			phpLoader.dataFormat = URLLoaderDataFormat.VARIABLES;			
			phpLoader.addEventListener(Event.COMPLETE, showResult);
			
			/*
			now lets create the variables to send to the php file
			*/
			
			phpVars.systemCall = "checkLogin";
			phpVars.email = email.text;
			
			/*
			this will start the communication between flash and php
			*/
			
			phpLoader.load(phpFileRequest);
		
		}
		
		/*
		function to show the result of the login
		*/
		
		public function showResult (event:Event):void {
			
			/*
			
			this autosizes the text field
			
			***** You will need to import flash's text classes. You can do this by: 
			
			import flash.text.*;
			
			*/
			
			result_text.autoSize = TextFieldAutoSize.LEFT;
			
			/*
			this gets the output and displays it in the result text field
			*/
			
			//result_text.text = "" + event.target.data.systemResult;
			
			if (event.target.data.systemResult == "login") {
				spinWheel(null);
				result_text.text = "" + event.target.data.systemResult;
			}
			if (event.target.data.systemResult == "logout") {
			//else {
				msg.msg_text.multiline = true;
				msg.msg_text.htmlText = "YOU’VE ALREADY ENTERED TODAY. <br>Come back tomorrow for another chance to win.";
				showMessage(null);
				disableAll(null);
				//redirect = true;
			}
		
		}
		
		/*
		function to listen mouse click
		*/
		
		public function listeners(action:String):void
		{
			if(action == 'add')
			{
				submit_button.addEventListener(MouseEvent.MOUSE_DOWN, checkLogin);
				//star1_mc.addEventListener(MouseEvent.MOUSE_DOWN, spinWheel);
				rules_btn.addEventListener(MouseEvent.MOUSE_DOWN, showRules);
				
			}
			else
			{
				submit_button.removeEventListener(MouseEvent.MOUSE_DOWN, checkLogin);
				//star1_mc.removeEventListener(MouseEvent.MOUSE_DOWN, spinWheel);
				rules_btn.removeEventListener(MouseEvent.MOUSE_DOWN, showRules);
			}
		}
		
		/*
		function to set speed and listen to frame
		*/
		
		public function spinWheel(e:MouseEvent):void
		{
			listeners('rm');		
			speed = Math.floor(Math.random() * 16) + 12;
			trace ("Speed: " + speed);
			stage.addEventListener(Event.ENTER_FRAME, spin);
			myTimer.start();
			myTimer.addEventListener(TimerEvent.TIMER, timeLimit);
		}
		
		/*
		function to rotate
		*/
		
		public function spin(e:Event):void
		{
					
			/* Rotate Wheel */
			wheel.rotation += rate;
			setSpeed();
			//wheel.filters = [blur];
						
			for(var i:int = 0; i < 16; i++)
			{
				//if(indicator.hArea.hitTestObject(paddles[i]))
				hAreaX = indicator.x;
				hAreaY = indicator.y;

				if(paddles[i].hitTestPoint(hAreaX,hAreaY,true))
				{
					lastPaddle = paddles[i].name;
					trace (paddles[i].name);
				}
			}
			
			/* Decrease speed */
			if (time == 3) {
				accelerate = false;
			}
			//speed -= 0.1;
			
			/* Remove lIstener and reset speed when wheel stops */
			
			if(rate <= 0)
			{
				stage.removeEventListener(Event.ENTER_FRAME, spin);
				myTimer.removeEventListener(TimerEvent.TIMER, timeLimit);
				speed = 10;
				run(lastPaddle);
				listeners('rm');
				disableAll(null);
				//trace ("mando form");
				sendForm();
			}
		}
		
		/*
		function to select the winner
		*/
		
		function run(action:String):void
		{
			switch(action)
			{
				case 'p1':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0xF15D5D, tintAmount:1}});
					result_text.text = "" + "p1 3x";
					price=3;
					break;
				case 'p2':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0xC06CA8, tintAmount:1}});
					result_text.text = "" + "p2 10x";
					price=10;
					break;
				case 'p3':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x644D9B, tintAmount:1}});
					result_text.text = "" + "p3 2x";
					price=2;
					break;
				case 'p4':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x5E98C6, tintAmount:1}});
					result_text.text = "" + "p4 5x";
					price=5;
					break;
				case 'p5':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x4789C2, tintAmount:1}});
					result_text.text = "" + "p5 3x";
					price=3;
					break;
				case 'p6':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x55C4CB, tintAmount:1}});
					result_text.text = "" + "p6 1x";
					price=1;
					break;
				case 'p7':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x57BC80, tintAmount:1}});
					result_text.text = "" + "p7 2x";
					price=2;
					break;
				case 'p8':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x90CC6C, tintAmount:1}});
					result_text.text = "" + "p8 3x";
					price=3;
					break;
				case 'p9':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0xEBE666, tintAmount:1}});
					result_text.text = "" + "p9 2x";
					price=2;
					break;
				case 'p10':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0xF29C69, tintAmount:1}});
					result_text.text = "" + "p10 3x";
					price=3;
					break;
				case 'p11':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0xF15D5D, tintAmount:1}});
					result_text.text = "" + "p11 5x";
					price=5;
					break;
				case 'p12':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0xC06CA8, tintAmount:1}});
					result_text.text = "" + "p12 1x";
					price=1;
					break;
				case 'p13':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x644D9B, tintAmount:1}});
					result_text.text = "" + "p13 2x";
					price=2;
					break;
				case 'p14':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x5E98C6, tintAmount:1}});
					result_text.text = "" + "p14 5x";
					price=5;
					break;
				case 'p15':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x4789C2, tintAmount:1}});
					result_text.text = "" + "p15 3x";
					price=3;
					break;
				case 'p16':
					//TweenMax.to(colorMC, 0.5, {colorTransform:{tint:0x55C4CB, tintAmount:1}});
					result_text.text = "" + "p16 2x";
					price=2;
					break;
			}
		}

		/*
		function to show message
		*/

		public function showMessage(e:MouseEvent):void
		{		
			msg.visible = true;
			msg.btn.addEventListener(MouseEvent.MOUSE_DOWN, windowBtn);
			disableAll(null);
			msg.alpha = 100;
		}
		
		/*
		function button message
		*/
		
		public function windowBtn(e:MouseEvent):void
		{
			if (redirect == true) {
				result_text.text = "redirect";
			}
			else{
				msg.visible = false;
				enableAll(null);
				msg.btn.removeEventListener(MouseEvent.MOUSE_DOWN, windowBtn);
			}
		}
		
		/*
		function to disable spin button
		*/
		
		function disableAll(e:MouseEvent):void
		{
			listeners('rm');
			submit_button.mouseEnabled = false;
			//submit_button.buttonMode = false;
		}
		
		/*
		function to enable spin button
		*/
		
		function enableAll(e:MouseEvent):void
		{
			listeners('add');
			submit_button.mouseEnabled = true;
			//submit_button.buttonMode = true;
		}
		
		/*
		function we use to send the form
		*/
		
		public function sendForm():void {
			
			/*
			we use the URLVariables class to store our php variables 
			*/
			
			var phpVars:URLVariables = new URLVariables();
			
			phpVars.fname = fname.text;
			phpVars.lname = lname.text;
			phpVars.email = email.text;
			phpVars.address = address.text;
			phpVars.suite = suite.text;
			phpVars.combo = combo.text;
			phpVars.zip = zip.text;
			phpVars.phone = phone.text;
			phpVars.price = price;
			phpVars.suscribe = suscribe.selected;
			phpVars.signup = signup.selected;

	
			/*
			we use the URLRequest method to get the address of our php file and attach the php vars.
			*/
			
			var urlRequest:URLRequest = new URLRequest("php/register.php");
			
			/*
			the POST method is used here so we can use php's $_POST function in order to recieve our php variables.
			*/
			
			urlRequest.method = URLRequestMethod.POST;
			
			/*
			this attaches our php variables to the url request
			*/
			
			urlRequest.data = phpVars;		
			
			/*
			we use the URLLoader class to send the request URLVariables to the php file
			*/
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			/*
			runs the function once the php file has spoken to flash
			*/
			
			urlLoader.addEventListener(Event.COMPLETE, showShare);

			/*
			we send the request to the php file
			*/
			
			urlLoader.load(urlRequest);
			
		}
		
		public function timeLimit(e:TimerEvent):void{
     		trace("Times Fired: " + e.currentTarget.currentCount);
			time = e.currentTarget.currentCount;
		}
		/* function to set speed and blur */
		public function setSpeed() {
			var blurTest = new BlurFilter(blurX, 0, 2);
			if (accelerate == true) {
				rate += acceleration;
       			rate = Math.min( rate, speed );
				
				if (rate >= 5) {
					blurX += 0.5;
					blurX = Math.min( blurX, 20 );
					wheel.filters = [blurTest];
				}
			}
			else {
				rate -= acceleration/4;
        		rate = Math.max( rate, 0 );
				if (rate <= 15) {
					blurX -= 0.5;
					blurX = Math.max( blurX, 0 );
					wheel.filters = [blurTest];
					trace ("blur x :" + blurX);
				}
			}
		}
		
		/* function to redirect to share */
	
		public function showShare (e:Event):void {
			navigateToURL(new URLRequest("php/share.php?price="+price),"_self");        
		}
		
		/* function to show rules */
		public function showRules(e:MouseEvent):void {
			rules.visible = true;
			rules.close.addEventListener(MouseEvent.MOUSE_DOWN, hideRules);
			disableAll(null);
			rules.close.buttonMode = true;
			rules.alpha = 100;
		}
		/* function to hide rules */
		public function hideRules(e:MouseEvent):void {
			rules.close.removeEventListener(MouseEvent.MOUSE_DOWN, hideRules);
			rules.visible = false;
			enableAll(null);
		}
		
		/* function to show validator msg */
		public function showValidator(e:MouseEvent):void {
			validator_msg.alpha = 100;
			disableAll(null);
			validator_msg.visible = true;
			validator_msg.validator_text.multiline = true;
			validator_msg.validator_text.autoSize = "left";
			validator_msg.validator_text.htmlText += "<br>";
			if( fname_error.text.length > 1 ) 
				{ 
					validator_msg.validator_text.htmlText += "<font size='13'>" + fname_error.text + "</font>";
				};
			if( lname_error.text.length > 1 ) 
				{ 
					validator_msg.validator_text.htmlText += "<font size='13'>" + lname_error.text + "</font>";
				};
			if( email_error.text.length > 1 ) 
				{ 
					validator_msg.validator_text.htmlText += "<font size='13'>" + email_error.text + "</font>";
				};
			if( address_error.text.length > 1 ) 
				{ 
					validator_msg.validator_text.htmlText += "<font size='13'>" + address_error.text + "</font>";
				};
			if( city_error.text.length > 1 ) 
				{ 
					validator_msg.validator_text.htmlText += "<font size='13'>" + city_error.text + "</font>";
				};
			if( combo_error.text.length > 1 ) 
				{ 
					validator_msg.validator_text.htmlText += "<font size='13'>" + combo_error.text + "</font>";
				};
			if( zip_error.text.length > 1 ) 
				{ 
					validator_msg.validator_text.htmlText += "<font size='13'>" + zip_error.text + "</font>";
				};
			if( terms_error.text.length > 1 ) 
				{ 
					validator_msg.validator_text.htmlText += "<font size='13'>" + terms_error.text + "</font>";
				};
			validator_msg.validator_text.htmlText += validator_msg_terms;
			validator_msg.close.addEventListener(MouseEvent.MOUSE_DOWN, hideValidator);
			validator_msg.msg_window.height =+ validator_msg.validator_text.textHeight + 30;
			validator_msg.close.buttonMode = true;
		}
		
		/* function to hide Validator */
		public function hideValidator(e:MouseEvent):void {
			validator_msg.close.removeEventListener(MouseEvent.MOUSE_DOWN, hideValidator);
			validator_msg.visible = false;
			validator_msg.validator_text.htmlText = "<b>PLEASE COMPLETE THE FOLLOWING<br>TO BE ABLE TO ENTER:**</b>";
			enableAll(null);
			emptyFields(null);
		}
		
		/* function to empty all fields */
		public function emptyFields(e:MouseEvent):void {
			fname_error.text = "";
			lname_error.text = "";
			email_error.text = "";
			address_error.text = "";
			city_error.text = "";
			combo_error.text = "";
			zip_error.text = "";
			terms_error.text = "";
		}
		

	/********************************************************/
	}

}