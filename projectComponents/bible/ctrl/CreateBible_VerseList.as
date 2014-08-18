package projectComponents.bible.ctrl
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import spark.components.VGroup;
	
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.act.ActBibleItem;
	import projectComponents.bible.views.item.BibleItem;
	
	public class CreateBible_VerseList extends CreateBibleBase
	{
		
		protected var gr:VGroup
		protected var nScrollerValue:Number
		
		public function CreateBible_VerseList(_ctrl:JScrollerActBase,_data:BibleDB)
		{
			super(_ctrl,_data);
			
			cLength = sql.$length
			cTotal = sql.$total
			
			scrollerCtrl.$slider = 1;
			gr = scrollerCtrl._getContentV()
			grV = gr
				
			addEventListener(JEvent.ALLCOMPLETE,function(event:JEvent):void{
				scroller.verticalScrollBar.viewport.verticalScrollPosition = nValue;
			})
			scroller.setStyle("movementDelta", 50);
		}
		
		
		override public function init():void
		{
			super.init()
			nLength = cTotal
			addItem(0,cTotal)
		}
		
		
		override public function next():void
		{
			super.next()
			addItem(0,cLength)
		}
		
		
		override public function prev():void
		{
			super.prev()
			nLength = cLength
			addItem(0,nLength)
		}
		
		
		override protected function createItem(_index:uint):UIComponent
		{
			var _item:BibleItem = new BibleItem
			_item.$data=(currModel.getBibleData(sql,_index))
			_item.percentWidth = 100;
			new ActBibleItem(_item);
			return _item
		}
		
		
		override protected function onItemEvent(event:Event):void
		{
			super.onItemEvent(event);
			var item:UIComponent = UIComponent(event.currentTarget)
			switch(event.type)
			{
				case Event.REMOVED_FROM_STAGE:
					nCount++
					nValue += gr.gap + item.height
					if (nCount == nLength)
					{
						switch(act)
						{
							
							case actNext:
								nValue = scroller.verticalScrollBar.value - nValue
								break;
							case actPrev:
								nValue = scroller.verticalScrollBar.value + nValue //- ( item.height)
								break
						}
						scroller.viewport.verticalScrollPosition = scroller.verticalScrollBar.value;
						ondelevent()
					}
					break
			}
		}
		
	}
}



