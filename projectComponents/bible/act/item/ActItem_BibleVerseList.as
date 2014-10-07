package projectComponents.bible.act.item
{
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import spark.components.Button;
	
	import JsC.events.JEvent;
	import JsC.events.JState;
	import JsC.mvc.ActionUI;
	
	import projectComponents.bible.viewers.item.BibleVerseList_item;
	
	
	[Event(name="NEWGAME", type="JsC.events.JEvent")]
	
	/** game finish*/
	[Event(name="SELECT", type="JsC.events.JEvent")]
	
	/** game finish*/
	[Event(name="FINISH", type="JsC.events.JEvent")]
	public class ActItem_BibleVerseList extends ActionUI
	{
		private var item:BibleVerseList_item
		
		private var bClick:Boolean
		private var bSelected:Boolean
		
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
					addEventListener(JEvent.FINISH,function(event:JEvent):void{
						if (!bSelected)
						{
							bClick = false
							item.currentState = JState.normal
						}
					})
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
					item.currentState = JState.down
				}else{
					item.currentState = JState.normal
				}
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