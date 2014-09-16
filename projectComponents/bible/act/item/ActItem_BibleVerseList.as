package projectComponents.bible.act.item
{
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import spark.components.Button;
	
	import JsC.events.JEvent;
	import JsC.mvc.ActionUI;
	
	import projectComponents.bible.viewers.item.BibleVerseList_item;
	
	
	[Event(name="NEWGAME", type="JsC.events.JEvent")]
	[Event(name="SELECT", type="JsC.events.JEvent")]
	public class ActItem_BibleVerseList extends ActionUI
	{
		private var item:BibleVerseList_item
		
		private var bClick:Boolean
		
		public function ActItem_BibleVerseList(_vi:UIComponent=null)
		{
			super(_vi);
			item = BibleVerseList_item(_vi)
			initCtrl()
		}
		
		private function initCtrl():void
		{
			item.addEventListener(MouseEvent.CLICK,onItemMouseEvent)
			item.addEventListener(JEvent.NEWGAME,onJEvent)
		}
		
		protected function onJEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.NEWGAME:
					sendEvent(JEvent.NEWGAME)
					break;
			}
		}
		
		protected function onItemMouseEvent(event:MouseEvent):void
		{
			if (!(event.target is Button))
			{
				bClick = !bClick
				if (bClick)
				{
					item.currentState = "selected"
				}else{
					item.currentState = "normal"
				}
				sendEvent(JEvent.SELECT)
			}
		}
		
		private function sendEvent(_type:String):void
		{
			var _event:JEvent = new JEvent(_type)
			_event._vo = item.$data
			dispatchEvent(_event)
		}
	}
}