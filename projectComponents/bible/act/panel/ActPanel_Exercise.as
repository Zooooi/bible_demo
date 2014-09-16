package projectComponents.bible.act.panel
{
	import mx.binding.utils.BindingUtils;
	
	import JsA.actionUI.ActGroupVList;
	import JsA.gameEngine.Game_DragAndDrop;
	
	import JsC.events.GameEvent;
	import JsC.events.JEvent;
	import JsC.events.MotionEvent;
	import JsC.mdel.JState;
	import JsC.mvc.ActionUI;
	
	import projectClass.vo.o.BibleOB;
	
	import projectComponents.bible.act.item.ActItem_Exercise_Btn;
	import projectComponents.bible.act.item.ActItem_Exercise_Rect;
	import projectComponents.bible.mdel.CreateExerciseModel;
	import projectComponents.bible.viewers.item.Exercise_FontBtn;
	import projectComponents.bible.viewers.item.Exercise_FontRect;
	import projectComponents.bible.viewers.panel.BibleExercise;
	
	public class ActPanel_Exercise extends ActionUI
	{
		
		private var vo:BibleOB
		private var view:BibleExercise
		
		private var actTop:ActGroupVList
		private var actBottom:ActGroupVList
		private var aTargetCtrl:Vector.<ActItem_Exercise_Rect>
		
		private var gameModel:CreateExerciseModel
		
		
		
		public function ActPanel_Exercise(_vi:BibleExercise=null)
		{
			super(_vi);
			view = _vi
			initAction()
			
			start()
		}
		
		private function initAction():void
		{
			view.addEventListener(JEvent.RESTART,function():void{
				restart()
			})
			gameModel = new CreateExerciseModel
			
			view.addEventListener(JEvent.CHANGED,function(event:JEvent):void{
				gameModel.nDegree = view.$degree
				restart()
			})
		}
		
		private function restMdel():void
		{
			gameModel = new CreateExerciseModel
			gameModel.nDegree = view.$degree
			vo = view.$data
			aTargetCtrl = new Vector.<ActItem_Exercise_Rect>
			
		}
		
		private function restCtrl():void
		{
			actTop = new ActGroupVList(view.$blackboard);
			actTop.bAction = false
			actTop.init()
			actBottom = new ActGroupVList(view.$source);
			actBottom.init()
			
			
		}
		
		private function restViews():void
		{
			
			/** 要分中英文版本*/
			var _btn:Exercise_FontBtn
			var _rect:Exercise_FontRect
			var _gameCtrl:Game_DragAndDrop = new Game_DragAndDrop(view.$draging)
			
			var _content:String = vo.content
			var i:int 
			
			
			/** Target ..............................................................................................................*/
			for (i = 0; i < _content.length; i++) 
			{
				var _text:String = _content.charAt(i)
				
				_rect = new Exercise_FontRect
				_rect.minWidth = 42
				_rect.minHeight = 42
				_rect.$num = (i+1)
				_rect.$text = _text
				actTop.addChild(_rect)
				
				var _targetCtrl:ActItem_Exercise_Rect = new ActItem_Exercise_Rect(_rect)
				if (gameModel.isSymbol(_text))
				{
					_targetCtrl.freeze()
					_targetCtrl.addChild(createBtn(_text))
				}else{
					gameModel.pushText(_text)
					_gameCtrl.addTarget(_rect)
					aTargetCtrl.push(_targetCtrl)
				}
				
			}
			
			gameModel.setTargetText(function(event:JEvent):void
			{
				aTargetCtrl[event.id].freeze()
				aTargetCtrl[event.id].addChild(createBtn(event.text))
			})
			
			gameModel.setSourceText(function(event:JEvent):void
			{
				var _btnCtrl:ActItem_Exercise_Btn
				_btn = createBtn(event.text)
				actBottom.addChild(_btn)
				_gameCtrl.addSource(_btn)
				_btnCtrl = new ActItem_Exercise_Btn(_btn)
			})
			
			
			_gameCtrl.addEventListener(GameEvent.ADDED_TO_TARGET,onGameEvent)
			_gameCtrl.addEventListener(GameEvent.CHANGE_TO_TARGET,onGameEvent)
			_gameCtrl.addEventListener(GameEvent.ADDED_TO_SOURCE,onGameEvent)
			_gameCtrl.addEventListener(GameEvent.RETURN_TO_SOURCE,onGameEvent)
			_gameCtrl.addEventListener(GameEvent.DRAG_START,onGameEvent)
			_gameCtrl._destory_From_View(view)
			_gameCtrl.init()
			
			_gameCtrl.addEventListener(JEvent.DESTORY,function(event:JEvent):void{
				_gameCtrl = null
				gameModel = null
			})
		}
		
		private function createBtn(_text:String):Exercise_FontBtn
		{
			var _btn:Exercise_FontBtn = new Exercise_FontBtn
			_btn.text = _text
			_btn.currentState = JState.onMouseUP
			return _btn
			
		}
		private function start():void
		{
			restMdel()	
			restCtrl()
			restViews()
		}
		
		private function clearData():void
		{
			actTop.removeAllChild()
			actBottom.removeAllChild()
		}
		private function restart():void
		{
			clearData()
			start()
		}
		
		protected function onGameEvent(event:GameEvent):void
		{
			var _btn:Exercise_FontBtn = Exercise_FontBtn(event._target)
			switch(event.type)
			{
				case GameEvent.DRAG_START:
					view.dispatchEvent(new JEvent(JEvent.STOP))
					_btn.currentState = JState.onMouseDW
					break
				case GameEvent.ADDED_TO_TARGET:
					if (aTargetCtrl[event._id].isFreeze())
					{
						return_event()
					}else{
						add_event()
					}
					break
				case GameEvent.CHANGE_TO_TARGET:
					add_event()
					break
				case GameEvent.RETURN_TO_SOURCE:
				case GameEvent.ADDED_TO_SOURCE:
					return_event()
					break;
			}
			
			
			function return_event():void
			{
				_btn.addEventListener(MotionEvent.MOVE_END,function(event:MotionEvent):void{
					event.currentTarget.removeEventListener(event.type,arguments.callee)
					actBottom.addChild(_btn)
					_btn.currentState = JState.onDropIn
				})
				_btn.dispatchEvent(new MotionEvent(MotionEvent.MOVINGOUT))
			}
			
			function add_event():void
			{
				aTargetCtrl[event._id].addChild(_btn)
				_btn.currentState = JState.onDropIn
			}
		}
	}
}