package projectComponents.bible.act
{
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import JsC.debug.CountTime;
	import JsC.events.JEvent;
	
	import projectComponents.bible.ctrl.DataLoader;
	import projectComponents.bible.viewers.panel.BibleReader;
	
	
	
	public class ActMain_Bible extends ActMain_Bible_Base
	{
		/**
		 * 
		 * ActBibleReader
		 *  
		 */	
		protected var view:BibleReader;
		
		public function ActMain_Bible(_vi:UIComponent) //BibleReader
		{
			super(_vi)
			view = BibleReader(_vi)
			view.addEventListener(FlexEvent.CREATION_COMPLETE,onFlexEvent)
		}
		
		
		protected function onFlexEvent(event:FlexEvent):void
		{
			switch(event.type)
			{
				case FlexEvent.CREATION_COMPLETE:
					
					__sqlProject = new DataLoader
					__sqlProject.addEventListener(JEvent.COMPLETE,onProjectEvent)
					break;
			}
		}		
		
		
		protected function onProjectEvent(event:JEvent):void
		{
			
			__sqlBible = __sqlProject.getBibleSQL()
				
			__actViews = new ActMain_Bible_Views(view)
			__actMenu = new ActMain_BibleMenu(view)
			__actBible = new ActMain_BibleContent(view)
			__actMenu.init()
				
			CountTime.display("__actMenu.init")
		}	
		

		
	}
}