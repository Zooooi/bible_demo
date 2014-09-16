package projectComponents.bible.act
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import projectComponents.bible.viewers.panel.BibleReader;
	
	public class ActMain_Bible_Views extends ActMain_Bible_Base
	{
		
		protected var view:BibleReader;
	
		private var _state:String;
		
		public function ActMain_Bible_Views(_vi:UIComponent=null)
		{
			super(_vi);
			view = BibleReader(_vi)
		}
		
		public function popUp(_ui:UIComponent):void
		{
			if (view.$container.numElements != 0)
			{
				view.$container.removeAllElements()
			}
			addChild(_ui)
		}
		
		public function addChild(_ui:UIComponent):void
		{
			_ui.addEventListener(FlexEvent.CREATION_COMPLETE,onEvent)
			view.$container.addElement(_ui)
		}
		
		protected function onEvent(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,arguments.callee)
			switch(event.type)
			{
				case Event.ADDED_TO_STAGE:
					_state = view.currentState
					view.currentState = "popup"
					event.currentTarget.addEventListener(Event.REMOVED_FROM_STAGE,onEvent)
					break;
				
				case Event.REMOVED_FROM_STAGE:
					view.currentState = _state
					break;
				
			}
			
			
		}
	}
}