package projectComponents.bible.act
{
	import mx.events.FlexEvent;
	
	import JsC.mvc.ActionObject;
	
	import JsF.components.act.JScrollerActV;
	
	import projectClass.ctrl.BibleDBReader;
	
	import projectComponents.bible.ex.JScrollerCtrlBibleVerseList;
	import projectComponents.bible.views.panel.BibleReader;
	
	public class ActBibleMain extends ActionObject
	{
		
		private var view:BibleReader;
		private var sql:BibleDBReader
		private var scrollerCtrl:JScrollerActV
		
		
		private var actBible2:JScrollerCtrlBibleVerseList
		private var actBible:ActBibleContent
		private var actMenu:ActBibleMenu
		/**
		 * 
		 * ActBibleReader
		 * 
		 */	
		public function ActBibleMain(_vi:Object) //BibleReader
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
					sql = new BibleDBReader
					
					/*Menu.....................................................................................................*/					
					actMenu = new ActBibleMenu(view)
					
					/*bible.....................................................................................................*/
					actBible = new ActBibleContent(view)
					
					//add.....................................................................................................*/
					actMenu._addModel(sql)
					actMenu._addAction(actBible);
					
					actBible._addModel(sql)
					actBible._addAction(actMenu);
					
					sql.load()
					break;
			}
		}		
	
		
	}
}