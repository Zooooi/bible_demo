package projectComponents.bible.act.item
{
	import mx.core.UIComponent;
	
	import JsA.gameEngine.Game_DragAndDrop;
	
	import JsC.events.JGameStateEvent;
	import JsC.mvc.ActionUI;
	import JsC.mvc.Controller;
	
	import projectComponents.bible.viewers.item.Exercise_FontBtn;
	
	public class ActItem_Exercise_Btn extends ActionUI
	{
		
		private var view:Exercise_FontBtn
		private var gameCtrl:Game_DragAndDrop
		
		public function ActItem_Exercise_Btn(_vi:Exercise_FontBtn=null)
		{
			super(_vi);
			view = _vi
		}
		
		override public function _addCtrl(_value:Controller):void
		{
			if (_value is Game_DragAndDrop)
			{
				gameCtrl = Game_DragAndDrop(_value)
				gameCtrl.addEventListener(JGameStateEvent.ADDED_TO_TARGET,onGameEvent)
				gameCtrl.addEventListener(JGameStateEvent.ADDED_TO_SOURCE,onGameEvent)
				gameCtrl.addEventListener(JGameStateEvent.RETURN_TO_SOURCE,onGameEvent)
				gameCtrl.addEventListener(JGameStateEvent.DRAG_UPDATE,onGameEvent)
			}
		}
		
		protected function onGameEvent(event:JGameStateEvent):void
		{
			trace(event)
		}
		
		
		override public function _addSymbol(_value:UIComponent):void
		{
			super._addSymbol(_value);
		}
		
	}
}