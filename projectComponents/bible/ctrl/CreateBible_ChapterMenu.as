package projectComponents.bible.ctrl
{
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.core.UIComponent;
	
	import spark.components.HGroup;
	import spark.components.Label;
	
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	import projectClass.vo.o.BibleOB;
	
	public class CreateBible_ChapterMenu extends CreateBibleBase
	{
		
		private var gr:HGroup
		private var vMenu:Vector.<BibleOB>
		private var nMenu:uint
		
		public function CreateBible_ChapterMenu(_ctrl:JScrollerActBase,_data:BibleDB)
		{
			super(_ctrl,_data);
			cTotal = 70;
			cLength = cTotal /2
			gr = scrollerCtrl._getContentH()
			grV = gr
			
			initCtrl()
		}
		
		
		private function initCtrl():void
		{
			scrollerCtrl.$slider = 5;
			scrollerCtrl.addEventListener(JEvent.ONEND,function():void{next()})
			scrollerCtrl.addEventListener(JEvent.ONSTART,function():void{prev()})
		}
		
		private function initValue():void
		{
			
			nMenu = cTotal
			var vData:Vector.<Object> = sql.getVoumes()
			vMenu = new Vector.<BibleOB>
			for (var i:int = 0; i < vData.length; i++) 
			{
				var _vo:BibleOB = currModel.getVolumesData(sql,i);
				var _itemVo:BibleOB = new BibleOB
				_itemVo.contentTitle = _vo.short_name
				vMenu.push(_itemVo);
				for (var j:int = 0; j < _vo.chapter; j++) 
				{
					_itemVo = new BibleOB
					_itemVo.chapter = j + 1
					vMenu.push(_itemVo);
				}
			}
		}
		
		
		override public function init():void
		{
			super.init()
		/*	initValue()
			addItem(0,cTotal)*/
		}
		
		
		override public function next():void
		{
			super.next()
			nLength = cLength
			nMenu += nLength
			addItem(nMenu-cLength,nMenu)
			setTimeout(function():void{scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))},500)
		}
		
		
		override public function prev():void
		{
			super.prev()
			var _b:Boolean
			if(nMenu == cTotal)
			{
				nMenu = 0
				nLength = cLength
				addItem(nMenu,nLength)
				nMenu += cLength
				_b = true
			}else if (nMenu>cLength){
				nLength = cLength
				addItem(nMenu-nLength,nMenu)
				nMenu += cLength
				_b = true
			}
			if (_b)setTimeout(function():void{scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))},500)
		}
		
		
		
		
		override protected function createItem(_index:uint):UIComponent
		{
			var _lable:Label
			var _item:UIComponent 
			if (vMenu[_index].contentTitle==null)
			{
				_lable = new Label
				_lable.text = String(vMenu[_index].chapter)
				_item = _lable
			}else{
				_lable = new Label
				_lable.text = vMenu[_index].contentTitle
				_item = _lable
			}
			return _item
		}
		
		
		override protected function onItemEvent(event:Event):void
		{
			super.onItemEvent(event);
			var item:UIComponent = UIComponent(event.currentTarget)
			switch(event.type)
			{
				case Event.REMOVED_FROM_STAGE:
					nCount++;
					nValue += (gr.gap + item.width)
					switch(act)
					{
						case actNext:
							scroller.horizontalScrollBar.value = scroller.horizontalScrollBar.maximum
							break;
						
						case actPrev:
							scroller.horizontalScrollBar.value = scroller.horizontalScrollBar.minimum
							break
					}
					if (nCount == nLength) 
					{
						switch(act)
						{
							case actNext:
								scroller.horizontalScrollBar.viewport.horizontalScrollPosition -= nValue
								break;
							
							case actPrev:
								scroller.horizontalScrollBar.viewport.horizontalScrollPosition += nValue
								break
						}
						
					}
					break
			}
		}
		
	}
}