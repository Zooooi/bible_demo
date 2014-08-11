package projectComponents.bible.act
{
	import mx.events.FlexEvent;
	
	import JsC.events.JEvent;
	import JsC.mvc.ActionObject;
	
	import JsF.components.act.JScrollerActH2;
	import JsF.components.act.JScrollerActV2;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.ctrl.CreateBible;
	import projectComponents.bible.ctrl.CreateChapter;
	import projectComponents.bible.views.panel.BibleReader;
	
	public class ActBibleReader extends ActionObject
	{
		
		private var view:BibleReader;
		private var sql:BibleDB
		private var createBible:CreateBible
		private var createChapter:CreateChapter
		private var scrollerCtrl:JScrollerActV2
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
					
					/*Bible.....................................................................................................*/
					scrollerCtrl = new JScrollerActV2(view.$scroller)
					scrollerCtrl.addEventListener(JEvent.ONSTART,onScrollEvent)
					scrollerCtrl.addEventListener(JEvent.ONEND,onScrollEvent)
					createBible = new CreateBible(scrollerCtrl,sql)
					
					/*Menu.....................................................................................................*/					
					var menuCtrl:JScrollerActH2 = new JScrollerActH2(view.$menu);
					menuCtrl.addEventListener(JEvent.ONSTART,onMenuScroller)
					menuCtrl.addEventListener(JEvent.ONEND,onMenuScroller)
					createChapter = new CreateChapter(menuCtrl,sql)
					break;
				
			}
		}		
		
			
		
		
		protected function onSQLEvent(event:JEvent):void
		{
			
			switch(event.type)
			{
				case JEvent.COMPLETE:
					createBible.init();
					sql.removeEventListener(JEvent.COMPLETE,arguments.callee);
					break
				
				case JEvent.NEXT:
					createBible.next()
					scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
					break
				
				case JEvent.PREV:
					createBible.prev();
					scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
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
		
		
		protected function onMenuScroller(event:JEvent):void
		{
			
		}	
		
	}
}