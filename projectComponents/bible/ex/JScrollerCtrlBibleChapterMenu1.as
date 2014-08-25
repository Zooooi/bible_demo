package projectComponents.bible.ex
{
	
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import spark.components.HGroup;
	import spark.layouts.HorizontalLayout;
	
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	import projectClass.vo.o.BibleOB;
	
	import projectComponents.bible.ex.JScrollerCtrlBibleBase;
	import projectComponents.bible.view.Views_BookLable;
	import projectComponents.bible.views.item.ChapterMenu_item_Number;
	import projectComponents.bible.views.symbol.VolumeCurrent;
	
	
	[Event(name="SELECT", type="JsC.events.JEvent")]
	
	public class JScrollerCtrlBibleChapterMenu1 extends JScrollerCtrlBibleBase
	{
		protected var currentVo:BibleOB
		protected var vMenu:Vector.<BibleOB>
		
		protected var gr:HGroup
		private var nMenu:int
		private var viewVolume:VolumeCurrent
		private var currentItem:ChapterMenu_item_Number
		
		
		public function JScrollerCtrlBibleChapterMenu1(_ctrl:JScrollerActBase,_data:BibleDB)
		{
			super(_ctrl,_data);
			
			cTotal = 60;
			cLength = cTotal /2
			gr = scrollerCtrl._getContentH()
			initCtrl()
		}
		
		
		private function initCtrl():void
		{
			scrollerCtrl.$slider = 5;
			scrollerCtrl.addEventListener(JEvent.ONEND,function():void{next()})
			scrollerCtrl.addEventListener(JEvent.ONSTART,function():void{prev()})
		}
		
		private function initValue():void
		{
			nMenu = cTotal
			var vData:Vector.<Object> = sql.getVoumes()
			vMenu = new Vector.<BibleOB>
			for (var i:int = 0; i <vData.length ; i++)
			{
				var _vo:BibleOB = currModel.getVolumesData(sql,i);
				var _itemVo:BibleOB = new BibleOB
				_itemVo.testament = _vo.testament
				_itemVo.sn =  _vo.sn
				_itemVo.sTitle = _vo.full_name
				_itemVo.nChapterLength = _vo.chapter
				vMenu.push(_itemVo);
				for (var j:int = 0; j < _vo.chapter; j++) 
				{
					_itemVo = new BibleOB
					_itemVo.testament = _vo.testament
					_itemVo.sTitle = _vo.full_name
					_itemVo.sn =  _vo.sn
					_itemVo.volume = _vo.sn
					_itemVo.nChapter = j + 1
					_itemVo.nChapterLength = _vo.chapter
					vMenu.push(_itemVo);
				}
			}
			
			currentVo = new BibleOB
			currentVo = vMenu[1]
		}
		
		
		override public function init():void
		{
			super.init()
			initValue()
			addItem(0,cTotal)
			nMenu = cTotal
			viewVolume.$data = currentVo
			
		}
		
		
		override public function next():void
		{
			super.next()
			if (nMenu < vMenu.length){
				nMenu += cLength
				nMenu = (nMenu>vMenu.length) ? vMenu.length : nMenu
				addItem(nMenu - cLength,nMenu)
			}else{
				scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
			}
			
		}
		
		
		override public function prev():void
		{
			super.prev()
			if (nMenu > cTotal){
				nMenu -= cTotal
				nMenu = (nMenu < 0) ? 0 : nMenu
				addItem(nMenu - cLength,nMenu)
				nMenu += cLength
			}else{
				scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
			}
		}
		
		
		
		
		override protected function createItem(_index:uint):UIComponent
		{
			var _item:UIComponent 
			var vo:BibleOB
			vo = vMenu[_index]
			if (vo.nChapter!=0)
			{
				var _numberItem:ChapterMenu_item_Number = new ChapterMenu_item_Number
				_numberItem.$data = vo
				_numberItem.addEventListener(MouseEvent.CLICK,onItemMouseEvent)
				if (currentVo.sn == vo.sn && currentVo.nChapter == vo.nChapter) 
				{
					currentItem = _numberItem
					_numberItem.selected = true
				}
				_item = _numberItem
			}else{
				var _text:Views_BookLable = new Views_BookLable
				_text.data = vo
				_item = _text
			}
			return _item
		}
		
		protected function onItemMouseEvent(event:MouseEvent):void
		{
			var _numberItem:ChapterMenu_item_Number = ChapterMenu_item_Number(UIComponent(event.currentTarget))
			var _elementIndex:uint = gr.getElementIndex(_numberItem)
			onSelectByElementByIndex(_elementIndex)
		}	
		
		
		
		override public function _addSymbol(_vi:UIComponent):void
		{
			if (_vi is VolumeCurrent)
			{
				viewVolume = VolumeCurrent(_vi)
			}
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
		
		
		protected function onSelectElement(_numberItem:ChapterMenu_item_Number,_elementIndex:uint):void
		{
			//effect
			if (currentItem == _numberItem)return 
				
			var lay:HorizontalLayout = gr.layout as HorizontalLayout;	
			var _x:Number = lay.getElementBounds(_elementIndex).x
			var _w:Number = _numberItem.width /2
			var _offset:Number = (_x + _w) -lay.horizontalScrollPosition - scroller.viewport.width/2
			
			aniScrollTo(_offset)
			
			//change page
			currentVo = _numberItem.$data
			currentItem = _numberItem 
			viewVolume.$data = currentVo
			_numberItem.selected = true
			//event
			onSelect()
		}
		
		protected function onSelect():void
		{
			
			// ActBibleMenu -> actChapter
			// send to
			// ActBibleMenu -> onChapterEvent
			// call <SQL.load> <actBible.display> 
			var _event:JEvent = new JEvent(JEvent.SELECT)
			_event._data = currentVo
			dispatchEvent(_event)
		}
		
	}
}



