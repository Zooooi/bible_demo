package projectComponents.bible.ctrls
{
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import JsC.events.JEvent;
	import JsC.mvc.ActionObject;
	
	import JsF.components.JScroller;
	import JsF.components.JScrollerAct;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.ctrls.item.ActBibleItem;
	import projectComponents.bible.views.item.BibleItem;
	import projectComponents.bible.views.panel.BibleReader;
	
	public class ActBibleReader extends ActionObject
	{
		
		private var view:BibleReader;
		private var scrollerCtrl:JScrollerAct
		private var scroller:JScroller
		
		private var sql:BibleDB
		public function ActBibleReader(_vi:Object)//ActBibleReader
		{
			view = BibleReader(_vi)
			view.addEventListener(FlexEvent.CREATION_COMPLETE,onFlexEvent)
		}
		
		protected function onFlexEvent(event:FlexEvent):void
		{
			switch(event.type)
			{
				case FlexEvent.CREATION_COMPLETE:
					sql = new BibleDB
					sql.addEventListener(JEvent.COMPLETE,onSQLEvent)
					sql.load()
					scroller = view.$Scroller
					scrollerCtrl = new JScrollerAct(scroller)
					scrollerCtrl.addEventListener(JEvent.ONTOP,onScrollEvent)
					scrollerCtrl.addEventListener(JEvent.ONBOTTOM,onScrollEvent)
					break;
				
			}
		}		
		
		protected function onSQLEvent(event:JEvent):void
		{
			for (var i:int = 0; i < sql.getBible().length; i++) 
			{
				var _item:BibleItem = new BibleItem
				_item.$data.fill(sql.getBible()[i])
				_item.percentWidth = 100;
				new ActBibleItem(_item);
				scrollerCtrl._addElement(_item)
			}
		}
		
		protected function onScrollEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.ONBOTTOM:
					sql.next()
				
					break;
					
				default:
					break;
			}
		}		
		
	}
}