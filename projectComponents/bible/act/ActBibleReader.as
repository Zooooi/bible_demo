package projectComponents.bible.act
{
	import mx.events.FlexEvent;
	
	import JsC.events.JEvent;
	import JsC.mvc.ActionObject;
	
	import JsF.components.act.JScrollerActV;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.ctrl.CreateBible_ChapterMenu;
	import projectComponents.bible.ctrl.CreateBible_VerseList;
	import projectComponents.bible.views.panel.BibleReader;
	
	public class ActBibleReader extends ActionObject
	{
		
		private var view:BibleReader;
		private var sql:BibleDB
		private var createBible:CreateBible_VerseList
		private var createMenu:CreateBible_ChapterMenu
		private var scrollerCtrl:JScrollerActV
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
					scrollerCtrl = new JScrollerActV(view.$scroller)
					scrollerCtrl.addEventListener(JEvent.ONSTART,onScrollEvent)
					scrollerCtrl.addEventListener(JEvent.ONEND,onScrollEvent)
					createBible = new CreateBible_VerseList(scrollerCtrl,sql)
					
					/*Menu.....................................................................................................*/					
					var menuCtrl:ActMenuScorller = new ActMenuScorller(view.$menu);
					createMenu = new CreateBible_ChapterMenu(menuCtrl,sql)
					break;
				
			}
		}		
		
			
		
		
		protected function onSQLEvent(event:JEvent):void
		{
			
			switch(event.type)
			{
				case JEvent.COMPLETE:
					createBible.init();
					createMenu.init()
					sql.removeEventListener(JEvent.COMPLETE,arguments.callee);
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