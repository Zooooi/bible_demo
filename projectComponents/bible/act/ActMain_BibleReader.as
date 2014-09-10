package projectComponents.bible.act
{
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import JsC.debug.CountTime;
	import JsC.events.JEvent;
	
	import projectComponents.bible.ctrl.DataLoader;
	import projectComponents.bible.viewers.panel.BibleReader;
	import projectComponents.bible.viewers.panel.BibleStyleFullScreen;
	
	public class ActMain_BibleReader extends ActMain_BibleBase
	{
		/**
		 * 
		 * ActBibleReader
		 * 
		 */	
		protected var view:BibleReader;
		
		public function ActMain_BibleReader(_vi:UIComponent) //BibleReader
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
			__actMenu = new ActMain_BibleMenu(view)
			__actBible = new ActMain_BibleContent(view)
			__actMenu.init()
			CountTime.display("__actMenu.init")
		}	
		
		
		public function addViewer_FullScreen(_ui:UIComponent):UIComponent
		{
			var _fullscreen:BibleStyleFullScreen = new BibleStyleFullScreen
			_fullscreen.addEventListener(FlexEvent.CREATION_COMPLETE,function():void{
				_fullscreen.$content.addElement(_ui)
				_fullscreen.$close.addEventListener(MouseEvent.CLICK,function():void{
					view.$container.removeAllElements()
				})
			})
			view.$container.addElement(_fullscreen)
			return _fullscreen
		}
	}
}