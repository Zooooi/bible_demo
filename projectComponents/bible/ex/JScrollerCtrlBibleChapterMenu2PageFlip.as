package projectComponents.bible.ex
{
	import mx.core.UIComponent;
	
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.views.item.ChapterMenu_item_Number;
	
	
	[Event(name="FINISH", type="JsC.events.JEvent")]
	public class JScrollerCtrlBibleChapterMenu2PageFlip extends JScrollerCtrlBibleChapterMenu1
	{
		
		private var nIndex:int
		private var hasButton:Boolean
		
		public function JScrollerCtrlBibleChapterMenu2PageFlip(_ctrl:JScrollerActBase, _data:BibleDB)
		{
			super(_ctrl, _data);
		}
		
		public function nextPage():void
		{
			setValue(+1)
		}
		
		
		public function prevPage():void
		{
			setValue(-1)
		}
		
		
		private function setValue(_number:Number):void
		{
			nIndex = vMenu.indexOf(currentVo)
			
			if (nIndex + _number==0 || nIndex + _number ==vMenu.length)
			{
				// ActBibleMenu -> actChapter
				// send to 
				// ActBibleMenu -> onChapterEvent
				// call actBible(ActBibleContent) ready event
				dispatchEvent(new JEvent(JEvent.FINISH))
				return
			}else{
				nIndex += _number
			}
			
				
			currentVo = vMenu[nIndex]
			hasButton = false

			
			if (currentVo.nChapter==0)
			{
				nIndex += _number
				currentVo = vMenu[nIndex]
			}
			
			var _item:ChapterMenu_item_Number
			for (var i:int = 0; i <gr.numElements ; i++) 
			{
				var _ui:UIComponent = UIComponent(gr.getElementAt(i))
				if(_ui is ChapterMenu_item_Number)
				{
					_item = ChapterMenu_item_Number(_ui)
					if (currentVo == _item.$data)
					{
						hasButton = true
						break
					}
				}
			}
			
			
			if (hasButton)
			{
				onSelectByElementByItem(_item)
			}else{
				
			}
		}
	}
}