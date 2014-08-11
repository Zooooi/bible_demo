package projectComponents.bible.ctrl
{
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	import spark.components.Scroller;
	import spark.components.VGroup;
	
	import JsC.events.JEvent;
	import JsC.mvc.Controller;
	
	import JsF.components.act.JScrollerActBase;
	import JsF.components.act.JScrollerActV2;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.act.ActBibleItem;
	import projectComponents.bible.model.CreateBibleModel;
	import projectComponents.bible.views.item.BibleItem;
	
	[Event(name="ADD", type="JsC.events.JEvent")]
	public class CreateBible extends Controller
	{
		private var sql:BibleDB
		private var scroller:Scroller
		private var scrollerCtrl:JScrollerActBase
		private var currModel:CreateBibleModel
		private var gr:VGroup
		private var nCount:uint;
		private var nLength:uint
		private var nTotal:uint
		private var nHeight:Number
		
		private var bNext:Boolean = true;
		public function CreateBible(_ctrl:JScrollerActV2,_data:BibleDB)
		{
			sql = _data
			nLength = sql.$length
			nTotal = sql.$total
			
			scrollerCtrl = _ctrl;
			scrollerCtrl.$slider = 1;
			gr = scrollerCtrl._getContentV()
			scroller = scrollerCtrl._getScroller()
			
			currModel = new CreateBibleModel
			_model = currModel
		}
		
		
		public function init():void
		{
			addEventListener(JEvent.ADD,onEvent_Next)
			run(nTotal)
		}
		
		
		public function next():void
		{
			bNext = true;
			addEventListener(JEvent.ADD,onEvent_Next)
			run(nLength)
		}
		
		
		public function prev():void
		{
			bNext = false;
			addEventListener(JEvent.ADD,onEvent_Prev)
			run(nLength)
		}
		
		
		private function run(_length:uint):void
		{
			nCount = 0;
			nHeight = 0;
			for (var i:int = 0; i <_length; i++) 
			{
				var _item:BibleItem = new BibleItem
				_item.$data=(currModel.getData(sql,i))
				_item.percentWidth = 100;
				new ActBibleItem(_item);
				if (_length == nLength)
				{
					_item.addEventListener(FlexEvent.CREATION_COMPLETE,onItemEvent)
					_item.addEventListener(Event.ADDED_TO_STAGE,onItemEvent)
				}
				_item.addEventListener(Event.REMOVED_FROM_STAGE,onItemEvent)
				if (bNext)
				{
					gr.addElement(_item)
				}else{
					gr.addElementAt(_item,0);
				}
			}
		}
		
		protected function onEvent_Next(event:JEvent):void
		{
			nCount = 0
			for (var i:int = 0; i <nLength; i++) 
			{
				gr.removeElementAt(0);
			}
		}
		
		
		protected function onEvent_Prev(event:JEvent):void
		{
			nCount = 0
			for (var i:int = 0; i <nLength; i++) 
			{
				gr.removeElementAt(gr.numElements-1);gr.numElements
			}
		}
		
		protected function onItemEvent(event:Event):void
		{
			var item:BibleItem = BibleItem(event.currentTarget)
			switch(event.type)
			{
				case FlexEvent.CREATION_COMPLETE:
				case Event.ADDED_TO_STAGE:
					item.removeEventListener(event.type,arguments.callee);
					nCount++;
					if (nCount == nLength*2) 
					{
						dispatchEvent(new JEvent(JEvent.ADD))
					}
					break;
				
				
				case Event.REMOVED_FROM_STAGE:
					nCount++;
					nHeight += gr.gap + item.height;
					if (nCount == nLength) 
					{
						if (bNext)
						{
							scroller.verticalScrollBar.value -= nHeight;
							scroller.verticalScrollBar.viewport.verticalScrollPosition -= nHeight
						}else{
							scroller.verticalScrollBar.value += nHeight;
							scroller.verticalScrollBar.viewport.verticalScrollPosition += nHeight
						}
					}
					break
			}
			
			
		}
		
	}
}

class SQL_Data
{
	
}

