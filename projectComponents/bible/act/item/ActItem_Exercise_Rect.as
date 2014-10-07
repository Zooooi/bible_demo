package projectComponents.bible.act.item
{
	import mx.core.UIComponent;
	
	import JsC.events.JGameStateEvent;
	import JsC.events.JEvent;
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
				
			view.addEventListener(JEvent.REMOVED,function(event:JEvent):void{view.$content.removeAllElements()})
			view.addEventListener(JEvent.CHECK,function(event:JEvent):void{
				event.currentTarget.removeEventListener(event.type,arguments.callee)
				if (view.$content.numElements && view.currentState == "normal")
				{
					var _event:JEvent = new JEvent(JEvent.SEND)
					var _btn:Exercise_FontBtn =  Exercise_FontBtn(view.$content.getElementAt(0))
					_event.i = view.$num
					var _b:Boolean = _btn.$text == view.$text
					_event._compare = _b
					view.dispatchEvent(_event)
					if (_b)
					{
						view.currentState = "right"
					}else{
						view.currentState = "wrong"
					}
				}
			})
		}
		
		public function addChild(_ui:UIComponent):void
		{
			var _newItem:Exercise_FontBtn = Exercise_FontBtn(_ui)
			
			if (view.$content.numElements)
			{
				item_old = Exercise_FontBtn(view.$content.getElementAt(view.$content.numElements-1))
				item_old.dispatchEvent(new JGameStateEvent(JGameStateEvent.RETURN_TO_SOURCE))
				item_old.dispatchEvent(new JGameStateEvent(JGameStateEvent.CHANGE_TO_TARGET))
			}
			
			item_new = _newItem
			item_new.x = 0
			item_new.y = 0
			view.$content.addElement(item_new)
		}
		
		public function freeze(_b:Boolean = true):void
		{
			if (_b)
			{
				view.currentState = "freeze"
			}else{
				view.currentState = "normal"
				
			}
			bFreeeze = _b
		}
		
		public function isFreeze():Boolean
		{
			return bFreeeze
		}
	}
}