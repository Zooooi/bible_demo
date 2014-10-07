package projectComponents.bible.act.panel
{
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import JsA.actionUI.ActGroupVList;
	import JsA.gameEngine.Game_DragAndDrop;
	
	import JsC.events.JEvent;
	import JsC.events.JGameEvent;
	import JsC.events.JGameStateEvent;
	import JsC.events.JState;
	import JsC.events.MotionEvent;
	import JsC.mvc.ActionUI;
	import JsC.string.Maths;
	
	import projectComponents.bible.act.item.ActItem_Exercise_Btn;
	import projectComponents.bible.act.item.ActItem_Exercise_Rect;
	import projectComponents.bible.mdel.CreateExerciseModel;
	import projectComponents.bible.viewers.item.Exercise_FontBtn;
	import projectComponents.bible.viewers.item.Exercise_FontRect;
	import projectComponents.bible.viewers.panel.BibleExercise;
	import projectComponents.bible.vo.BibleOB;
	import projectComponents.bible.vo.BibleScore;
	import projectComponents.bible.vo.ExerciseVO;
	
	
	public class ActPanel_Exercise extends ActionUI
	{
		private const cTime1:uint = 200
		private const cTime2:uint = 160
		
		private var vo:BibleOB
		private var view:BibleExercise
		
		private var actTop:ActGroupVList
		private var actBottom:ActGroupVList
		private var aTargetCtrl:Vector.<ActItem_Exercise_Rect>
		
		private var gameModel:CreateExerciseModel
		private var gameCtrl:Game_DragAndDrop
		private var score:BibleScore
		private var voExercise:ExerciseVO
		
		private var currentID:int = -1
		private var currentTarget:Exercise_FontRect
		private var currentBtn:Exercise_FontBtn
		private var currentOnTip:Boolean
		private var currentTime:uint
		private var date:Date
		
		public function ActPanel_Exercise(_vi:BibleExercise=null)
		{
			super(_vi);
			view = _vi
			initAction()
			
			start()
		}
		
		private function initAction():void
		{
			view.addEventListener(JEvent.RESTART,onViewJEvent)
			view.addEventListener(JEvent.CHANGED,onViewJEvent)
			view.addEventListener(JEvent.SELECT,onViewJEvent)
				
			gameModel = new CreateExerciseModel
				
			actTop = new ActGroupVList(view._grBlackboard);
			actTop.bAction = false
			actTop.init()
		}
		
		
		private function restMdel():void
		{
			date = new Date
			currentTarget = null
			voExercise = view._exercise
			gameModel = new CreateExerciseModel
			gameModel.nDegree = view._exercise.degree
			
			vo = view._data
			aTargetCtrl = new Vector.<ActItem_Exercise_Rect>
		}
		
		private function restCtrl():void
		{
			actBottom = new ActGroupVList(view._grSource);
			actBottom.init()
		}
		
		private function initViews(_r:Boolean = false):void
		{
			view.dispatchEvent(new JGameEvent(JGameEvent.START))
			
			var _rect:Exercise_FontRect
			
			var _content:String = gameModel.setText(vo.content)
			var i:int
			
			var _text:String
			var _targetCtrl:ActItem_Exercise_Rect
			var _b:Boolean
			
			gameCtrl = new Game_DragAndDrop(view.$draging)
			gameCtrl._delayTime = cTime1
			
			if (!_r){
				for (i = 0; i < _content.length; i++) 
				{
					_text = _content.charAt(i)
					
					_rect = new Exercise_FontRect
					_rect.minWidth = 50
					_rect.minHeight = 50
					_rect.$num = (i+1)
					_rect.$text = _text
					_rect.addEventListener(JEvent.SEND,onCheckJEvent)
					
					
					actTop.addChild(_rect)
					_targetCtrl = new ActItem_Exercise_Rect(_rect)
					_b = gameModel.isSymbol(_text)
					_targetCtrl.freeze(_b)
					if (_b)
					{
						_targetCtrl.addChild(createBtn(_text))
					}else{
						gameModel.pushText(_text)
						gameCtrl.addTarget(_rect)
						aTargetCtrl.push(_targetCtrl)
					}
				}
			}else{
				for (i = 0; i < _content.length; i++) 
				{
					_rect = Exercise_FontRect(actTop.getChildAt(i))
					
					_text = _content.charAt(i)
					
					_targetCtrl = new ActItem_Exercise_Rect(_rect)
					_b = gameModel.isSymbol(_text)
					_targetCtrl.freeze(_b)
					if (_b)
					{
						_targetCtrl.addChild(createBtn(_text))
					}else{
						gameModel.pushText(_text)
						gameCtrl.addTarget(_rect)
						aTargetCtrl.push(_targetCtrl)
					}
				}
			}
			
		}
		
		
		private function setUpGameModel():void
		{
			var _btn:Exercise_FontBtn
			var _count:uint = 0
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
				gameCtrl.addSource(_btn)
				_count ++
				_btnCtrl = new ActItem_Exercise_Btn(_btn)
			})
			voExercise.compare = _count
			voExercise.tips = _count
			gameModel.setExerciseVo(voExercise)
			
			gameCtrl.addEventListener(JGameEvent.FINISH,onGameEvent)
			gameCtrl.addEventListener(JGameStateEvent.DRAG_UPDATE,onGameStateEvent)
			gameCtrl.addEventListener(JGameStateEvent.ADDED_TO_TARGET,onGameStateEvent)
			gameCtrl.addEventListener(JGameStateEvent.CHANGE_TO_TARGET,onGameStateEvent)
			gameCtrl.addEventListener(JGameStateEvent.ADDED_TO_SOURCE,onGameStateEvent)
			gameCtrl.addEventListener(JGameStateEvent.RETURN_TO_SOURCE,onGameStateEvent)
			gameCtrl.addEventListener(JGameStateEvent.DRAG_START,onGameStateEvent)
				
			gameCtrl._destory_From_View(view,function(event:JEvent):void{gameCtrl = null;gameModel = null	})
			gameCtrl.init()
			
		}
		
		
		private function createBtn(_text:String):Exercise_FontBtn
		{
			var _btn:Exercise_FontBtn = new Exercise_FontBtn
			_btn.$text = _text
			_btn.currentState = JState.onMouseUP
			return _btn
			
		}
		
		
		private function start():void
		{
			restMdel()	
			restCtrl()
			initViews()
			setUpGameModel()
		}
		
		private function restartAction():void
		{
			restMdel()	
			restCtrl()
			initViews(true)
			setUpGameModel()
		}
		
		private function clearData():void
		{
			actTop.ergodic(function(event:JEvent):void{
				event._view.dispatchEvent(new JEvent(JEvent.REMOVED))
			})
			actBottom.removeAllChild()
		}
		private function restart():void
		{
			clearData()
			restartAction()
		}
		
		protected function onCheckJEvent(event:JEvent):void
		{
			score.nCount ++
			if (event._compare)
			{
				score.nRight ++
			}else{
				score.nWrong ++
			}
		}
		
		
		protected function onViewJEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.RESTART:
				case JEvent.CHANGED:
					restart()
					break;
				case JEvent.SELECT:
					var _ran:uint = Math.round(Math.random()*(actBottom.getLength()-1))
					var _btn:Exercise_FontBtn = Exercise_FontBtn(actBottom.getChildAt(_ran))
					for (var i:int = 0; i < actTop.getLength(); i++) 
					{
						var _rect:Exercise_FontRect = Exercise_FontRect(actTop.getChildAt(i))
						if (_rect.currentState !="freeze" && _btn.$text == _rect.$text)
						{
							_btn.$num = _rect.$num.toString()
							_btn.dispatchEvent(event)
							voExercise.fast -- 
							break
						}
					}
					
					break
			
				
			}
		}
		
		protected function onGameStateEvent(event:JGameStateEvent):void
		{
			clearInterval(currentTime)
			var _btn:Exercise_FontBtn = Exercise_FontBtn(event._current)
			switch(event.type)
			{
				case JGameStateEvent.DRAG_START:
					view.dispatchEvent(new JEvent(JEvent.STOP))
					_btn.currentState = JState.onMouseDW
					break
				case JGameStateEvent.ADDED_TO_TARGET:
					if (aTargetCtrl[event._id].isFreeze())
					{
						gameCtrl.removeCurrent()
						return_event()
					}else{
						add_event()
					}
					break
				case JGameStateEvent.CHANGE_TO_TARGET:
					add_event()
					break
				case JGameStateEvent.RETURN_TO_SOURCE:
				case JGameStateEvent.ADDED_TO_SOURCE:
					return_event()
					break;
				
				case JGameStateEvent.DRAG_UPDATE:
					if (event._hitTest)
					{
						
						if (currentTarget)
						{
							currentTarget.dispatchEvent(new JEvent(JEvent.READY))
							currentTarget = null
						}
						
						if (voExercise.tips != 0 && !voExercise.bTips_Selected && _btn.$num ==null){
							currentTime = setInterval(function():void{
								clearInterval(currentTime)
								if (currentID != event._id)
								{
									currentBtn = _btn
									currentTarget = Exercise_FontRect(event._target)
									
									var _event:JEvent 
									if (_btn.$text == currentTarget.$text)
									{
										_event = new JEvent(JEvent.CORRECT)
									}else{
										_event = new JEvent(JEvent.WRONG)
									}
									_event.kind = "tips"
									currentTarget.dispatchEvent(_event)
									currentBtn.dispatchEvent(_event)
									
									currentOnTip = true
									voExercise.tips -- 
									currentID = event._id
								}
							},cTime2)
						}
					}else
					{
						if (currentTarget != null)
						{
							currentTarget.dispatchEvent(new JEvent(JEvent.READY))
							currentOnTip = false
							currentTarget = null
							currentID = -1
						}
						if (currentBtn != null)
						{
							currentBtn.dispatchEvent(new JEvent(JEvent.READY))
							currentBtn = null
						}
					}
					break
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
				
				currentTarget = Exercise_FontRect(aTargetCtrl[event._id]._getView())
				
				if (_btn.$text == currentTarget.$text)
				{
					gameModel.getGif(voExercise)
				}
				
				if (!currentOnTip && _btn.$num == null && voExercise.compare != 0 && !voExercise.bCompare_Selected) 
				{
					if (_btn.$text == currentTarget.$text)
					{
						//currentTarget.dispatchEvent(new JEvent(JEvent.CORRECT))
					}else{
						voExercise.compare --
						currentTarget.dispatchEvent(new JEvent(JEvent.WRONG))
					}
					
				}
				_btn.$num = null
				
			}
		}
		
		
		protected function onGameEvent(event:JGameEvent):void
		{
			switch(event.type)
			{
				case JGameEvent.FINISH:
					
					score = new BibleScore
					actTop.ergodic(function(event:JEvent):void{
						event._view.dispatchEvent(new JEvent(JEvent.CHECK))
					})
					var _countTime:uint = ((new Date).getTime() - date.getTime())
					var _aTime:Array = Maths.TimeCode(_countTime)
					var _sTime:String = _aTime[1] + " : " + _aTime[2]
					score.sTime = _sTime
					score.nSecond = _countTime / 1000
					score._addVO(voExercise)
					
					
					var _event:JGameEvent = new JGameEvent(JGameEvent.FINISH)
					_event._vo = score
					view.dispatchEvent(_event)
			}
		}
	}
}