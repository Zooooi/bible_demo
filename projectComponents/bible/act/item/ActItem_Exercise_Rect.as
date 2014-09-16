package projectComponents.bible.act.item
{
	import mx.core.UIComponent;
	
	import JsC.events.GameEvent;
	import JsC.mvc.ActionUI;
	
	import projectComponents.bible.viewers.item.Exercise_FontBtn;
	import projectComponents.bible.viewers.item.Exercise_FontRect;
	
	public class ActItem_Exercise_Rect extends ActionUI
	{	
		
		private var view:Exercise_FontRect
		private var item_new:Exercise_FontBtn
		private var item_old:Exercise_FontBtn
		
		private var bFreeeze:Boolean
		public function ActItem_Exercise_Rect(_vi:UIComponent=null)
		{
			super(_vi);
			view = Exercise_FontRect(_vi)
		}
		
		public function addChild(_ui:UIComponent):void
		{
			var _newItem:Exercise_FontBtn = Exercise_FontBtn(_ui)
			
			if (view.$content.numElements)
			{
				item_old = Exercise_FontBtn(view.$content.getElementAt(view.$content.numElements-1))
				item_old.dispatchEvent(new GameEvent(GameEvent.RETURN_TO_SOURCE))
				item_old.dispatchEvent(new GameEvent(GameEvent.CHANGE_TO_TARGET))
			}
			
			item_new = _newItem
			item_new.x = 0
			item_new.y = 0
			view.$content.addElement(item_new)
		}
		
		public function freeze():void
		{
			view.currentState = "freeze"
			bFreeeze = true
		}
		
		public function isFreeze():Boolean
		{
			return bFreeeze
		}
	}
}