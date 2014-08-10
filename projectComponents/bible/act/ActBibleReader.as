package projectComponents.bible.act
{
	import mx.events.FlexEvent;
	
	import JsC.events.JEvent;
	import JsC.mvc.ActionObject;
	
	import JsF.components.JScrollerV;
	import JsF.components.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.ctrl.CreateBible;
	import projectComponents.bible.views.panel.BibleReader;
	import JsF.components.JScrollerActV2;
	
	public class ActBibleReader extends ActionObject
	{
		
		private var view:BibleReader;
		private var scrollerCtrl:JScrollerActBase
		private var scrollerView:JScrollerV
		
		private var sql:BibleDB
		private var createBible:CreateBible
		
		
		/**
		 * 
		 * ActBibleReader
		 * 
		 */	
		public function ActBibleReader(_vi:Object)
		{
			view = BibleReader(_vi)
			view.addEventListener(FlexEvent.CREATION_COMPLETE,onFlexEvent)
		}
		
		protected function onFlexEvent(event:FlexEvent):void
		{
			switch(event.type)
			{
				case FlexEvent.CREATION_COMPLETE:
					
					/*sql...........................................................................................................*/
					sql = new BibleDB
					sql.addEventListener(JEvent.COMPLETE,onSQLEvent)
					sql.addEventListener(JEvent.NEXT,onSQLEvent)
					sql.addEventListener(JEvent.PREV,onSQLEvent)
					sql.load()
					
					/*scroller.....................................................................................................*/
					scrollerView = view.$Scroller
					scrollerCtrl = new JScrollerActV2(scrollerView)
					scrollerCtrl.addEventListener(JEvent.ONSTART,onScrollEvent)
					scrollerCtrl.addEventListener(JEvent.ONEND,onScrollEvent)
					/*createBible..................................................................................................*/
					createBible = new CreateBible(sql,scrollerCtrl)
					break;
				
			}
		}		
		
		
		
		protected function onSQLEvent(event:JEvent):void
		{
			
			switch(event.type)
			{
				case JEvent.COMPLETE:
					createBible.init();
					break
				
				case JEvent.NEXT:
					createBible.next()
					break
				
				case JEvent.PREV:
					createBible.prev();
					break
			}
			
		}
		
		protected function onScrollEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.ONEND:
					sql.next()
					break;
				
				case JEvent.ONSTART:
					sql.prev()
					break;
			}
		}		
		
	}
}