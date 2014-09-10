package projectComponents.bible.ext
{
	
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.core.UIComponent;
	
	import spark.components.HGroup;
	
	import JsC.debug.CountTime;
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.vo.o.BibleOB;
	import projectClass.vo.v.BibleVA;
	
	import projectComponents.bible.ctrl.DataBibleController;
	import projectComponents.bible.view.Views_BookLable;
	import projectComponents.bible.viewers.item.ChapterMenu_item_Number;
	import projectComponents.bible.viewers.symbol.VolumeCurrent;
	
	
	[Event(name="SELECT", type="JsC.events.JEvent")] //extra
	[Event(name="MENU", type="JsC.events.JEvent")] //extra
	
	public class JScrollerCtrlBibleChapterMenu1 extends JScrollerCtrlBibleBase
	{
		private const cDelay:uint = 5000
			
		private var nDelay:uint = cDelay
		
		
		protected var currentVo:BibleOB //vo: currentData
		protected var currentChildren:uint //uint
		protected var currentItem:ChapterMenu_item_Number //uicomponent: display chapter
		protected var currentMenuNumber:uint
		
		
		protected var vMenu:Vector.<BibleOB> //vector: database
		protected var gr:HGroup //container:
		
		private var nMenu:int  //int: current chapter gr children number
		private var viewVolume:VolumeCurrent //uicomponent: display volume
		
		private var nDisplayCurrentButtonID:uint //uint,id:
		private var bCurrentButtonAction:Boolean
		
		private var bClick:Boolean
		
		public function JScrollerCtrlBibleChapterMenu1(_ctrl:JScrollerActBase,_data:DataBibleController)
		{
			super(_ctrl,_data);
			cTotal = 60;
			cLength = cTotal /2
			gr = scrollerCtrl._getContentH()
			
		}
		
		
		private function initCtrl():void
		{
			viewVolume.addEventListener(MouseEvent.CLICK,function():void{
				var _vo:BibleOB = new BibleOB(viewVolume.$data.toObject())
				_vo.kind = BibleVA.kind_volume
				sendData(_vo)
			})
			
			scrollerCtrl.addEventListener(JEvent.ONEND,function():void{next()})
			scrollerCtrl.addEventListener(JEvent.ONSTART,function():void{prev()})
			scroller.viewport.addEventListener(MouseEvent.MOUSE_MOVE,function(event:MouseEvent):void
			{
				if (event.buttonDown)
				{
					aniScrollStop()
					bCurrentButtonAction = true
					onDisplayCurrentButtonFunction(nDelay)
				}
			})
			scroller.viewport.addEventListener(MouseEvent.MOUSE_DOWN,function(event:MouseEvent):void
			{
				clearInterval(nDisplayCurrentButtonID)
			})
			CountTime.display("menu list initCtrl")
		}
		
		
		private function initValue():void
		{
			scrollerCtrl.$slider = 5;
			nMenu = cTotal
			var vData:Vector.<BibleOB> = sql.getVoumes()
			vMenu = new Vector.<BibleOB>
			for (var i:int = 0; i <vData.length ; i++)
			{
				var _vo:BibleOB = vData[i]
				vMenu.push(currModel.getMenuButtonLabel(_vo));
				for (var j:int = 0; j < _vo.chapter; j++) 
				{
					vMenu.push(currModel.getMenuButtonNumber(_vo,j));
				}
			}
		}
		
		
		override protected function createItem(_index:uint):UIComponent
		{
			var _item:UIComponent 
			var vo:BibleOB
			vo = vMenu[_index]
			if (vo.kind == BibleVA.kind_chapter)
			{
				var _numberItem:ChapterMenu_item_Number = new ChapterMenu_item_Number
				_numberItem.$data = vo
				_numberItem.addEventListener(MouseEvent.CLICK,onItemMouseEvent_number)
				if (checkCurrentVo(vo))
				{
					currentItem = _numberItem
					_numberItem.selected = true
				}
				_item = _numberItem
			}else{
				var _volumeItem:Views_BookLable = new Views_BookLable
				_volumeItem.addEventListener(MouseEvent.CLICK,onItemMouseEvent_volume)
				_volumeItem.data = vo
				_item = _volumeItem
			}
			CountTime.display("bible menu createItem")
			return _item
		}
		
		
		override public function _addSymbol(_vi:UIComponent):void
		{
			if (_vi is VolumeCurrent)
			{
				viewVolume = VolumeCurrent(_vi)
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * Navigator
		 * 
		 ********************************************************************************************************************************************************************/
		override public function init():void
		{
			/*super.init()
			initValue()
			addItem(0,cTotal)
			nMenu = cTotal
			currentMenuNumber = nMenu
			viewVolume.$data = currentVo
			initCtrl()*/
			initValue()
			initCtrl()
		}
		
		
		override public function next():void
		{
			super.next()
			aniScrollStop()
			addEventListener(JEvent.ALLCOMPLETE,onDisplayCurrentButtonEvent)
			if (nMenu < vMenu.length){
				nMenu += cLength
				addItem(nMenu - cLength - onModifyMenu(),nMenu)
			}else{
				scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
			}
		}
		
		
		override public function prev():void
		{
			super.prev()
			aniScrollStop()
			addEventListener(JEvent.ALLCOMPLETE,onDisplayCurrentButtonEvent)
			if (nMenu > cTotal){
				nMenu -= cTotal
				nMenu = (nMenu < 0) ? 0 : nMenu
				addItem(nMenu - cLength,nMenu)
				nMenu += cLength
			}else{
				scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
			}
		}
		
		
		private function onModifyMenu():uint
		{
			var n:uint = 0
			if (nMenu >= vMenu.length){
				nMenu = vMenu.length
				n = currentMenuNumber - nMenu
			}else if (nMenu < 0){
				nMenu = 0
				n = cLength - currentMenuNumber
			}
			return n
		}
		
		
		
		
		/**********************************************************************************************************************************************************************/
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/**
		 * 
		 * event
		 * 
		 * 
		 ************************************************************************************************************************************************************/
		protected function onDisplayCurrentButtonEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.ALLCOMPLETE:
					removeEventListener(event.type,arguments.callee)
					bCurrentButtonAction = true
					if (bClick)
					{
						onDisplayCurrentButtonFunction(nDelay / 10)
						bClick = false
					}else{
						onDisplayCurrentButtonFunction(nDelay)
					}
					break;
			}
			
		}
		
		
		protected function onItemMouseEvent_volume(event:MouseEvent):void
		{
			var _item:Views_BookLable = Views_BookLable(event.currentTarget)
			sendData(_item.data)
		}
		
		
		protected function onItemMouseEvent_number(event:MouseEvent):void
		{
			var _numberItem:ChapterMenu_item_Number = ChapterMenu_item_Number(UIComponent(event.currentTarget))
			if (currentItem == _numberItem) return 
			bClick = true
			var _elementIndex:uint = gr.getElementIndex(_numberItem)
			onSelectByElementByIndex(_elementIndex)
		}	
		
		
		
		
		/************************************************************************************************************************************************************/
		
		
		
		
		
		
		
		
		
		
		/**
		 * 
		 * onScrollAction
		 * 
		 * 
		 ************************************************************************************************************************************************************/
		protected function onScrollAction():void
		{
			scrollerCtrl.openCheckEvent() /** autoCheck ONTOP & ONEND EVENT*/
			aniScrollToIndex(currentChildren,gr.getElementAt(currentChildren).width / 2)
		}
		
		protected function onSelectByElementByIndex(_elementIndex:uint):void
		{
			var _numberItem:ChapterMenu_item_Number = ChapterMenu_item_Number(gr.getElementAt(_elementIndex))
			onSelectElement(_numberItem,_elementIndex)
		}
		
		protected function onSelectByElementByItem(_numberItem:ChapterMenu_item_Number):void
		{
			var _elementIndex:uint = gr.getElementIndex(_numberItem)
			onSelectElement(_numberItem,_elementIndex)
		}
		
		
		protected function onSelectElement(_numberItem:ChapterMenu_item_Number,_elementIndex:uint,_motion:Boolean = true):void
		{
			scrollerCtrl.openCheckEvent() /** autoCheck ONTOP & ONEND EVENT*/
			aniScrollStop()
			bCurrentButtonAction = false
			clearInterval(nDisplayCurrentButtonID)
				
			currentMenuNumber = nMenu
			currentChildren = _elementIndex
			currentItem = _numberItem
			currentVo = currentItem.$data
				
			currentItem.selected = true
			viewVolume.$data = currentVo
				
			if (_motion)
			{
				aniScrollToIndex(_elementIndex,currentItem.width/2)
			}else{
				scroller.viewport.horizontalScrollPosition = gr.layout.getElementBounds(_elementIndex).x - scroller.viewport.width/2 + currentItem.width/2
			}
			onDispSelectEvent()
		}
		
		
		
		
		/************************************************************************************************************************************************************/
		
		
		
		
		
		
		
		
		protected function checkAndUpdateExist():Boolean
		{
			var _b:Boolean = false
			var _item:ChapterMenu_item_Number
			if (currentItem != null)
			{
				for (var i:int = 0; i <gr.numElements ; i++) 
				{
					var _ui:UIComponent = UIComponent(gr.getElementAt(i))
					if(_ui is ChapterMenu_item_Number)
					{
						_item = ChapterMenu_item_Number(_ui)
						if (checkCurrentVo(_item.$data))
						{
							currentVo = _item.$data
							currentItem = _item
							currentMenuNumber = nMenu
							currentChildren = i
							_b = true
							break
						}
					}
				}
			}
			return _b	
		}
		
		
		
		
		/**
		 *ActBibleMenu.actChapter -> ActBibleMenu.onChapterEvent
		 *= SQL.load & actBible.display
		 */
		protected function onDispSelectEvent():void
		{
			var _event:JEvent = new JEvent(JEvent.SELECT)
			_event._data = currentVo
			dispatchEvent(_event)//-> ActBibleMenu
		}
		
		
		
		
		
		/**
		 * 
		 * 經過User MouseEvent.Mouse_Move 後, 判斷是否回到當前按鈕位置，或重新載入
		 * 
		 */		
		protected function onDisplayCurrentButtonFunction(_time:uint):void
		{
			clearInterval(nDisplayCurrentButtonID)
			nDisplayCurrentButtonID = setInterval(function():void{
				clearInterval(nDisplayCurrentButtonID)
				if (bCurrentButtonAction)
				{
					if (checkAndUpdateExist())
					{
						onScrollAction()
					}else{
						onReloadCurrentButton()
					}
				}
			},_time)
		}
		
		
		
		
		/**
		 * 重載入當前button
		 */		
		protected function onReloadCurrentButton(_b:Boolean = false):void
		{
			removeAllElement();
			addEventListener(JEvent.INIT,function(event:JEvent):void
			{
				removeEventListener(event.type,arguments.callee)
				checkAndUpdateExist() 
				/**
				 * 重新定位
				 * _b == false 自動緩衝定位
				 * _b == true  自動無緩衝定位並觸發按鈕事件 
				 * */
				if (!_b)
				{
					onScrollAction()
				}else{
					onSelectElement(currentItem,currentChildren,false)
				}
			})
			super.init()
			nMenu = currentMenuNumber
			addItem(nMenu - cTotal - onModifyMenu(),nMenu)
		}
		
		
		
		
		private function checkCurrentVo(vo:BibleOB):Boolean
		{
			return currentVo.sn == vo.sn && currentVo.nChapter == vo.nChapter
		}
		
		
		
		
		private function sendData(_vo:BibleOB):void
		{
			var _event:JEvent = new JEvent(JEvent.SELECT)
			_event._data = _vo
			dispatchEvent(_event) //-> ActBibleMenu
		}
		
		
		
	}
}



